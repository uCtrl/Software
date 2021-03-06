import QtQuick 2.0

import "../ui/UColors.js" as Colors
import "../ui" as UI
import "../label" as ULabel
import "../condition" as UConditions

import DeviceEnums 1.0

Rectangle {
    id: taskEditorContainer
    property var taskModel
    property var conditionModel

    property var deviceType: null

    signal saveConditions()
    signal saveTasks()

    anchors.fill: parent
    color: Colors.uWhite

    onConditionModelChanged: {
        refreshConditionCountLabel()
    }

    Rectangle
    {
        id: editorContent
        width: parent.width
        anchors.top: parent.top
        anchors.bottom: saveButton.top
        anchors.bottomMargin: 10

        Column
        {
            anchors.fill: parent
            spacing: 5
            Rectangle
            {
                id: editorHeader
                width: parent.width
                height: 50

                UI.UFontAwesome
                {
                    id: editorHeaderIcon
                    iconId: "Cog"
                    iconSize: 24
                    iconColor: Colors.uGrey

                    anchors.left: parent.left
                    anchors.leftMargin: 15
                    anchors.verticalCenter: parent.verticalCenter
                }

                ULabel.Default
                {
                    text: "Task configuration"
                    font.pointSize: 20
                    anchors.left: editorHeaderIcon.right
                    anchors.leftMargin: 20
                    anchors.verticalCenter: parent.verticalCenter
                    color: Colors.uGrey
                }
            }

            Rectangle
            {
                id: taskContainer
                width: parent.width
                height: 50

                Row
                {
                    height: parent.height
                    anchors.left: parent.left
                    anchors.right: createConditionButton.left
                    spacing: 3
                    ULabel.ConditionLabel
                    {
                        font.pointSize: 16
                        text: "Set to "
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Loader {
                        id: fileLoader

                        active: false
                        asynchronous: true
                        anchors.verticalCenter: parent.verticalCenter

                        width: 130
                        height: 40

                        onVisibleChanged:      { loadIfNotLoaded(); }
                        Component.onCompleted: { loadIfNotLoaded(); }

                        function loadIfNotLoaded () {
                            // to load the file at first show
                            if (visible && !active) {
                                active = true;
                            }

                            setSource("type/" + getConditionFile() + ".qml", { "model": taskModel });
                        }
                    }

                    ULabel.ConditionLabel
                    {
                        id: whenLabel
                        font.pointSize: 16
                        text: countConditions() > 0 ? " when" : " otherwise"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

                UI.UButton
                {
                    id: createConditionButton
                    text: "New condition"
                    width: 150
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    onClicked: createNewCondition()
                }
            }
            Rectangle
            {
                color: Colors.uWhite
                width: parent.width
                height: 10
            }

            Rectangle
            {
                id: conditionHeaderContainer
                width: parent.width
                height: 20

                ULabel.ConditionLabel
                {
                    text: "Conditions"
                    font.pointSize: 12

                    anchors.verticalCenter: parent.verticalCenter
                }
                ULabel.ConditionLabel
                {
                    id: countConditionsLabel
                    font.pointSize: 12
                    anchors.right: parent.right

                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Rectangle
            {
                color: Colors.uLightGrey
                width: parent.width
                height: 2
            }
            Rectangle
            {
                width: parent.width
                height: editorContent.height - y
                clip: true

                ListView
                {
                    id: conditionEditorListView
                    anchors.fill: parent

                    model: conditionModel

                    delegate: UConditions.ConditionEditor {
                        id: cdnEditor
                        conditionModel: model
                        z: countConditions() - index
                        color: index % 2 === 0 ? Colors.uWhite : Colors.uUltraLightGrey

                        Component.onCompleted: {
                            taskEditorContainer.saveConditions.connect(cdnEditor.saveForm)
                        }
                    }
                }
            }
        }
    }

    UI.USaveCancel
    {
        id: saveButton
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        onSave: saveForm()
        onCancel: cancelEditing()
    }

    function createNewCondition()
    {
        var newCondition = conditionModel.createNewCondition();
        uCtrlApiFacade.postCondition(newCondition)

        refreshConditionCountLabel()
    }

    function saveForm() {
        if (devicePage.getPlatform().isLocalPlatform())
        {
            console.log("Local platform saved")
            doSaveTasks()
            taskEditorContainer.saveConditions()
        }
        else
        {
            console.log("Remote platform saved")
            taskEditorContainer.saveConditions()

            doSaveTasks()
        }
        taskEditorContainer.visible = false
    }

    function doSaveTasks()
    {
        saveTasks()
        uCtrlApiFacade.putTask(taskModel)
    }

    function cancelEditing()
    {
        taskEditorContainer.visible = false
    }

    function countConditions()
    {
        if (conditionModel !== null && conditionModel !== undefined) return conditionModel.rowCount
        else return 0
    }

    function refreshConditionCountLabel()
    {
        countConditionsLabel.text = countConditions() + " condition(s)"
        whenLabel.text = countConditions() > 0 ? " when" : " otherwise"
    }

    function getTaskValue()
    {
        if (taskModel !== null && taskModel !== undefined) return taskModel.value()
        else return ""
    }

    function getConditionFile() {
        if (deviceType !== null) {
            switch(deviceType) {
                case UEValueType.Switch:
                    return "Switch"
                case UEValueType.Slider:
                    return "Slider"
                case UEValueType.UpDownSwitch:
                    return "UpDownSwitch"
                case UEValueType.Color:
                    return "ColorPicker"
                default:
                    return "Textbox"
            }
        }
        return "Error"
    }
}
