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

    function startEditing() {
        isEditing = true

        textboxScenarioTitle.text = selectedScenario.name
    }

    function stopEditing() {
        isEditing = false
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
            id: comboScenario
            height: 40
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.right: editButton.left
            anchors.rightMargin: 5

            visible: !isEditing

            onSelectValue: {
                if(newValue === "add") {
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

            }

            onCancel: {
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

            scenario: selectedScenario

            isEditMode: isEditing
        }
    }
}
