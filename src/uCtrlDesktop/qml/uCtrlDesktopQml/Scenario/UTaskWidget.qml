import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Item {
    property var taskModel: taskList.model.getTaskAt(index)
    property bool isEditMode: true
    property bool showButtons: true

    id: taskWidget

    width: parent.width
    height: 40 + conditionsContainer.adjustedHeight()

    Rectangle {
        id: shadow

        width: parent.width
        height: parent.height +1
        color: _colors.uUltraLightGrey
    }

    Rectangle {
        id: scenarioFrame

        x:0
        y:0

        width: parent.width
        height: parent.height -1

        Rectangle {
            id: taskHeader
            z:1

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 10

            width: parent.width - anchors.leftMargin
            height: 40

            ULabel.Default {
                id: changeStateLabel
                text: "Set to"
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
                color: _colors.uDarkGrey
            }

            Rectangle {
                id: stateContainer
                color: _colors.uTransparent

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: changeStateLabel.right
                anchors.leftMargin: 15

                width: statusTaskLoader.width + 15
                height: statusTaskLoader.height

                radius: 10

                Loader {
                    id: statusTaskLoader
                    sourceComponent: getSourceComponent()

                    function getSourceComponent() {
                        if (taskModel.scenario.device.isTriggerValue) {
                            return statusComboBox
                        }

                        return statusTextBox
                    }

                    Component {
                        id: statusComboBox

                        UI.USwitch
                        {
                            anchors.centerIn: parent
                            state: taskModel.status

                            onStateChanged: {
                                setTaskStatus(state)
                            }
                        }
                    }

                    // TODO: Validate stuff with min max values + format with precision??
                    Component {
                        id: statusTextBox

                        UI.UTextbox {
                            width: 100
                            text: taskModel.status

                            onTextChanged: {
                                statusTaskLoader.setTaskStatus(text)
                            }
                        }
                    }

                    function setTaskStatus(newStatus) {
                        taskModel.status = newStatus
                    }
                }
            }

            ULabel.Default {
                id: stateLabelWhen

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: stateContainer.right

                text: taskModel.scenario.device.unitLabel + " when"
                font.pointSize: 14
                color: _colors.uDarkGrey

                Component.onCompleted: text = taskModel.scenario.device.unitLabel + " when"
            }

            Loader {
                anchors.verticalCenter: changeStateLabel.verticalCenter
                anchors.right: parent.right
                sourceComponent: getSourceComponent()

                function getSourceComponent() {
                    if (showButtons && !isEditMode)
                        return taskButtons

                    if (isEditMode)
                        return taskEditButtons

                    return emptyTaskButtonsComponent
                }
            }

            Component {
                id: emptyTaskButtonsComponent

                Rectangle {
                    width:0
                    height:0
                }
            }

            Component {
                id: taskEditButtons

                UI.USaveCancel {
                    height: changeStateLabel.height
                    width: height*2.5

                    onSave: save()
                    onCancel: isEditMode = false
                }
            }

            Component {
                id: taskButtons

                Rectangle {
                    UI.UButton {
                        id: editTaskButton

                        buttonColor: _colors.uWhite
                        buttonHoveredColor: _colors.uMediumLightGrey
                        buttonTextColor : _colors.uBlack

                        anchors.verticalCenter: parent.verticalCenter

                        iconId: "Pencil"
                        iconSize: 12

                        width: 20
                        height: 20

                        anchors.right: moveUp.left
                        anchors.rightMargin: 10

                        function execute() {
                            isEditMode = true
                        }
                    }

                    UI.UButton {
                        id: moveUp

                        buttonColor: _colors.uWhite
                        buttonHoveredColor: _colors.uMediumLightGrey
                        buttonTextColor : _colors.uBlack
                        buttonDisabledColor: _colors.uWhite
                        buttonDisabledTextColor: _colors.uMediumLightGrey

                        anchors.verticalCenter: parent.verticalCenter

                        iconId: "Upload"
                        iconSize: 12

                        width: 20
                        height: 20

                        anchors.right: moveDown.left
                        anchors.rightMargin: 10

                        function execute() {
                            var pScenario = taskModel.scenario
                            pScenario.moveTask(index, index - 1)
                        }
                    }


                    UI.UButton {
                        id: moveDown

                        buttonColor: _colors.uWhite
                        buttonHoveredColor: _colors.uMediumLightGrey
                        buttonTextColor : _colors.uBlack

                        anchors.verticalCenter: parent.verticalCenter

                        iconId: "Download"
                        iconSize: 12

                        width: 20
                        height: 20

                        anchors.right: deleteBtn.left
                        anchors.rightMargin: 10

                        function execute() {
                            var pScenario = taskModel.scenario
                            pScenario.moveTask(index, index + 1)
                        }
                    }

                    UI.UButton {
                        id: deleteBtn

                        buttonColor: _colors.uWhite
                        buttonHoveredColor: _colors.uMediumLightGrey
                        buttonTextColor : _colors.uBlack

                        anchors.verticalCenter: parent.verticalCenter

                        iconId: "Remove"
                        iconSize: 12

                        width: 20
                        height: 20

                        anchors.right: parent.right
                        anchors.rightMargin: 10

                        function execute() {
                            var pScenario = taskModel.scenario
                            pScenario.deleteTaskAt(index)
                        }
                    }
                }
            }
        }

        Rectangle {
            id: conditionsContainer
            clip: true

            height: 40 * conditionList.count
            width: parent.width

            x:0
            y: taskHeader.height

            color: _colors.uTransparent

            function adjustedHeight(){
                return visible? height: 0
            }

            ListView {
                id: conditionList
                anchors.fill: parent
                model: taskModel
                spacing:5
                interactive:false

                delegate: UTaskConditionWidget {
                }
            }
        }
    }
}
