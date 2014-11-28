import QtQuick 2.0

import "../label" as ULabel
import "../ui/UColors.js" as Colors
import "../ui/" as UI

Rectangle {

    id: scenarios

    property var model: null
    property bool showEditMode: false
    property var editTaskFunction

    onModelChanged: {
        showEditMode = false
        refreshComboBox()
        scenarioCombo.selectItem(0)
    }

    Rectangle
    {
       id: noScenario
       anchors.top: parent.top
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.bottom: createScenarioButton.top

       visible: (model !== null && model !== undefined && !(model.rowCount > 0))

       color: Colors.uTransparent

       anchors.fill: parent
       Rectangle
       {
           width: parent.width
           height: noScenarioLabel.height
           anchors.centerIn: parent
           ULabel.Default {
               id: noScenarioLabel
               anchors.horizontalCenter: parent.horizontalCenter
               text: "No scenario available"
               width: parent.width * 0.75
               font.bold: true
               font.pointSize: 32
               horizontalAlignment: Text.AlignHCenter


               color: Colors.uGrey
           }
       }
    }

    Rectangle {
        id: scenarioContainer
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: createScenarioButton.top

        visible: (model !== null && model !== undefined && model.rowCount > 0)

        color: Colors.uTransparent

        Rectangle
        {
            id: scenarioHeader
            width: parent.width
            height: 50

            UI.UFontAwesome
            {
                id: scHeaderIcon
                iconId: "Cog"
                iconSize: 24
                iconColor: Colors.uGrey

                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
            }

            ULabel.Default
            {
                text: "Scenario configuration"
                font.pointSize: 20
                anchors.left: scHeaderIcon.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.uGrey
            }
        }

        Scenario {
            id: currentScenario

            width: parent.width
            anchors.top: scenarioSelectionHeader.bottom
            anchors.topMargin: 95
            anchors.bottom: parent.bottom

            editTaskFunction: scenarios.editTaskFunction

            visible: (currentScenario.model != null)
        }

        Rectangle
        {
            id: scenarioEditHeader
            width: parent.width
            height: 35
            anchors.top: scenarioHeader.bottom

            visible: showEditMode

            UI.UTextbox
            {
                id: editScenarioName
                anchors.left: parent.left
                anchors.right: scenarioSaveCancel.left
                anchors.rightMargin: 10
                height: parent.height

                placeholderText: "Enter a scenario name"

                function validate() {
                    return text !== ""
                }

                state: (validate() ? "SUCCESS" : "ERROR")
            }

            UI.USaveCancel
            {
                id: scenarioSaveCancel
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                onSave: saveForm()
                onCancel: toggleEditMode()
            }
        }

        Rectangle
        {
            id: scenarioSelectionHeader
            width: parent.width
            height: 35
            anchors.top: scenarioHeader.bottom

            visible: !showEditMode

            UI.UCombobox {
                id: scenarioCombo

                anchors.left: parent.left
                anchors.right: editButton.left
                anchors.rightMargin: 10

                height: parent.height

                Component.onCompleted: {
                    selectItem(0)
                    currentScenario.model = scenarios.model.getRow(0)
                }

                onSelectedItemChanged: {
                    if (scenarios.model !== null && scenarios.model !== undefined && selectedItem !== null && typeof(selectedItem) !== "undefined")
                    {
                        currentScenario.model = scenarios.model.findObject(selectedItem.value)
                    }
                }
             }

            UI.UButton
            {
                id: editButton
                width: parent.height
                height: parent.height
                iconId: "pencil"

                anchors.right: deleteButton.left
                anchors.rightMargin: 5

                onClicked: toggleEditMode()
            }

            UI.UButton
            {
                id: deleteButton
                width: parent.height
                height: parent.height
                iconId: "Trash"

                buttonColor: Colors.uDarkRed
                buttonHoveredColor: Colors.uRed
                buttonTextColor : Colors.uWhite

                anchors.right: parent.right

                onClicked: deleteScenario()
            }
        }
    }

    UI.UButton
    {
        id: createScenarioButton
        text: "Create new scenario"
        iconId: ""
        iconSize: 12
        width: 225
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        onClicked: {
            createNewScenario()
        }

    }

    UI.UButton
    {
        id: createTaskButton
        text: "Create new task"
        iconId: ""
        iconSize: 12
        width: 225
        anchors.verticalCenter: createScenarioButton.verticalCenter
        anchors.left: createScenarioButton.right
        anchors.leftMargin: 10

        visible: currentScenario !== null && currentScenario !== undefined && currentScenario.showEditMode

        onClicked: createNewTask()
    }

    function refreshComboBox(){

        var selectedItemValue = scenarioCombo.selectedItem

        if (model !== null && model !== undefined)
        {
            var newComboModel = []

            for (var i = 0;i < model.rowCount; i++)
            {
                newComboModel.push({ value: model.getRow(i).id(), displayedValue: model.getRow(i).name(), iconId: "" })
            }

            scenarioCombo.itemListModel = newComboModel

            if(selectedItemValue !== null && typeof(selectedItemValue) !== "undefined")
            {
                scenarioCombo.selectItemByValue(selectedItemValue.value)
            }
        }
    }

    function createNewScenario()
    {
        var scenario = scenarios.model.createNewScenario()
        uCtrlApiFacade.postScenario(scenario)

        refreshComboBox()

        noScenario.visible = false
        scenarioContainer.visible = true

        // TODO : Update the interface to show the newly created scenario
        currentScenario.model = scenario
        changeEditMode(true)
    }

    function createNewTask()
    {
        var task = scenarios.model.nestedModelFromId(currentScenario.model.id()).createNewTask();
        uCtrlApiFacade.postTask(task)

        editTaskFunction(task, task.conditions())
    }

    function saveForm()
    {
        var scenario = scenarios.model.findObject(currentScenario.model.id())

        if (scenario !== null) {
            scenario.name(editScenarioName.text)
            currentScenario.model.name(editScenarioName.text)
        }

        uCtrlApiFacade.putScenario(scenario)
        toggleEditMode()
        refreshComboBox()
        scenarioCombo.selectItemByValue(scenario.id())
    }

    function toggleEditMode()
    {
        changeEditMode(!showEditMode)
    }

    function changeEditMode(newEditMode)
    {
        showEditMode = newEditMode
        currentScenario.showEditMode = showEditMode

        if(currentScenario.model !== null)
        {
            editScenarioName.text = currentScenario.model.name()
        }
    }

    function deleteScenario()
    {
        var scenario = scenarios.model.findObject(currentScenario.model.id());
        uCtrlApiFacade.deleteScenario(scenario)
        scenarios.model.removeRowWithId(scenario.id());

        if(scenarios.model.rowCount < 1)
        {
            noScenario.visible = true
            scenarioContainer.visible = false

        }

        scenarioCombo.clearSelectItem();
        refreshComboBox();
    }
}
