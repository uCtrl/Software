import QtQuick 2.0

import "../ui/UColors.js" as Colors
import "../ui" as UI
import "../label" as ULabel

Rectangle {
    id: taskEditorContainer
    property var taskModel
    property var conditionModel

    anchors.fill: parent
    color: Colors.uWhite

    onTaskModelChanged: {
        valueTextbox.text = getTaskValue()
    }

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
                    UI.UTextbox
                    {
                        id: valueTextbox
                        width: 130
                        height: 40
                        placeholderText: "Value"
                        anchors.verticalCenter: parent.verticalCenter
                        text: getTaskValue()

                        function validate()
                        {
                            return text !== "";
                        }

                        state: validate() ? "SUCCESS" : "ERROR"
                    }
                    ULabel.ConditionLabel
                    {
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
                    anchors.fill: parent

                    model: conditionModel

                    delegate: ConditionEditor {
                        conditionModel: model
                        z: countConditions() - index
                        color: index % 2 === 0 ? Colors.uWhite : Colors.uUltraLightGrey
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

    function saveForm()
    {
        taskModel.value(valueTextbox.text)

        uCtrlApiFacade.putTask(taskModel)

        taskEditorContainer.visible = false
    }

    function cancelEditing()
    {
        taskEditorContainer.visible = false
    }

    function countConditions()
    {
        if(conditionModel !== null && conditionModel !== undefined) return conditionModel.rowCount()
        else return 0
    }

    function refreshConditionCountLabel()
    {
        countConditionsLabel.text = countConditions() + " condition(s)"
    }

    function getTaskValue()
    {
        if (taskModel !== null && taskModel !== undefined) return taskModel.value()
        else return ""
    }
}
