import QtQuick 2.0

import "../UI" as UI
import "../Scenario" as Scenario

Rectangle {
    id: configTab
    anchors.fill: parent

    property bool isEditing: false

    property var device
    property var selectedScenario
    function refresh(newDevice) {
        device = newDevice

        comboScenario.itemListModel = comboScenario.getItemListModel()
        selectedScenario = device.getScenarioAt(0)

        scenarioWindow.refresh(selectedScenario)
    }

    function saveScenario() {
        isEditing = false

        scenarioWindow.scenarioModel.name = textboxScenarioTitle.text

        var i
        if(comboScenario.newScenario !== null) {
            device.addScenario(scenarioWindow.scenarioModel)
            i = device.getScenarioCount() - 1
            comboScenario.newScenario = null
        }
        else {
            i = parseInt(comboScenario.selectedItem.value)
            selectedScenario.updateScenario(scenarioWindow.scenarioModel)
        }

        comboScenario.itemListModel = comboScenario.getItemListModel()
        comboScenario.selectItem(i)
    }

    function startEditing() {
        isEditing = true

        textboxScenarioTitle.text = selectedScenario.name
        scenarioWindow.refresh(selectedScenario.copyScenario())
    }

    function stopEditing() {
        isEditing = false

        if (comboScenario.newScenario !== null) {
            comboScenario.newScenario = null
            comboScenario.selectItem(0)
        }
        scenarioWindow.refresh(selectedScenario)
    }

    color: _colors.uTransparent

    Rectangle {
        id: scenarioContainer
        width: parent.width
        height: 40
        color: _colors.uTransparent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        UI.UForm {
            id: configForm
            controlsToValidate: [ textboxScenarioTitle ]

            onAfterValidate: {
                saveForm.changeSaveButtonState(isValid)
            }
        }

        UI.UComboBox {
            property var newScenario: null

            id: comboScenario
            height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: editButton.left
            anchors.rightMargin: 5

            visible: !isEditing

            onSelectValue: {
                if(newValue === "add") {
                    newScenario = device.createScenario()
                    newScenario.name = "New Scenario"
                    selectedScenario = newScenario
                    scenarioWindow.refresh(selectedScenario)
                    startEditing()
                } else if(typeof(device) !== "undefined") {
                    var intValue = parseInt(newValue)
                    selectedScenario = device.getScenarioAt(intValue)
                    scenarioWindow.refresh(selectedScenario)
                }
            }

            function getItemListModel() {
                var scenarioComboModel = []
                for(var i = 0; i < device.getScenarioCount(); i++) {
                    scenarioComboModel.push({"value":i.toString(), "displayedValue":device.getScenarioAt(i).name, "iconId":"" })
                }

                scenarioComboModel.push({"value":"add", "displayedValue":"Add a new scenario", "iconId":"Plus" })

                selectedItem = scenarioComboModel[0]
                return scenarioComboModel
            }
        }

        UI.UTextbox {
            id: textboxScenarioTitle

            height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: saveForm.left
            anchors.rightMargin: 5

            visible: isEditing
            placeholderText: "Enter a scenario name"

            function validate() {
                return text !== ""
            }

            state: (validate() ? "SUCCESS" : "ERROR")

            onTextChanged: {
                configForm.validate()
            }
        }

        UI.USaveCancel {
            id: saveForm
            height: 40

            visible: isEditing

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            onSave: {
                scenarioWindow.saveTasks()
                saveScenario()
                //stopEditing()
                model.saveScenarios()
            }

            onCancel: {
                scenarioWindow.cancelEditTasks()
                stopEditing()
            }
        }

        UI.UButton {
            id: editButton
            width: 40
            height: 40
            iconId: "Pencil"
            anchors.verticalCenter: parent.verticalCenter

            anchors.right: deleteButton.left
            anchors.rightMargin: 5

            visible: !isEditing

            onClicked: {
                startEditing()
            }

        }
        UI.UButton {
            id: deleteButton
            width: 40
            height: 40
            iconId: "Trash"
            anchors.verticalCenter: parent.verticalCenter

            anchors.right: parent.right

            buttonColor: _colors.uDarkRed
            buttonHoveredColor: _colors.uRed

            visible: !isEditing

            onClicked: {
                var i = parseInt(comboScenario.selectedItem.value)
                device.deleteScenarioAt(i)

                comboScenario.itemListModel = comboScenario.getItemListModel()
                comboScenario.selectItem(0)
            }
        }

        z: 2
    }

    Rectangle {
        id: tabsContentContainer
        color: _colors.uTransparent
        width: parent.width
        anchors.top: scenarioContainer.bottom
        anchors.bottom: parent.bottom
        anchors.topMargin: 15

        Scenario.UScenarioWidget {
            id: scenarioWindow

            width: parent.width
            height: parent.height

            isEditMode: isEditing
        }
    }
}
