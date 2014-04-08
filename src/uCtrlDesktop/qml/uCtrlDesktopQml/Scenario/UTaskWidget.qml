import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Item {
    property var taskModel: taskList.model.getTaskAt(index)
    property bool isEditMode: false
    property bool showButtons: true

    property bool canMoveUp: !(index === 0 || index === taskList.count - 1)
    property bool canMoveDown: !(index === taskList.count - 1 || index === taskList.count - 2)

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
                text: qsTr("Set to")
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

                property string tmpValue: taskModel.status

                Loader {
                    id: statusTaskLoader
                    sourceComponent: getSourceComponent()

                    function getSourceComponent() {
                        if (!isEditMode)
                            return statusLabel

                        if (taskModel.scenario.device.isTriggerValue) {
                            return statusComboBox
                        }

                        return statusTextBox
                    }
                }

                Component {
                    id: statusLabel

                    Rectangle {
                        width: 100
                        height: changeStateLabel.height
                        radius: 5
                        color: _colors.uGreen

                        ULabel.Heading3 {
                            text: taskModel.status
                            anchors.horizontalCenter: parent.horizontalCenter
                            anchors.verticalCenter: parent.verticalCenter

                            color: _colors.uWhite
                        }
                    }
                }

                Component {
                    id: statusComboBox

                    UI.USwitch
                    {
                        anchors.centerIn: parent
                        state: taskModel.status

                        onStateChanged: {
                            stateContainer.tmpValue = state
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
                            stateContainer.tmpValue = text
                        }
                    }
                }
            }

            ULabel.Default {
                id: stateLabelWhen

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: stateContainer.right

                text: getText()
                font.pointSize: 14
                color: _colors.uDarkGrey

                function getText() {
                    if (index == taskList.count - 1)
                        return taskModel.scenario.device.unitLabel + " " + qsTr("otherwise")

                    return taskModel.scenario.device.unitLabel + " " + qsTr("when")
                }
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

                    onSave: saveTask()
                    onCancel: cancelEditTask()

                    function saveTask() {
                        taskModel.status = stateContainer.tmpValue
                        isEditMode = false
                    }

                    function cancelEditTask() {
                        stateContainer.tmpValue = taskModel.status
                        isEditMode = false
                    }
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
                            if (!canMoveUp)
                                return

                            var pScenario = taskModel.scenario
                            pScenario.moveTask(index, index - 1)
                        }
                    }


                    UI.UButton {
                        id: moveDown

                        buttonColor: _colors.uWhite
                        buttonHoveredColor: _colors.uMediumLightGrey
                        buttonTextColor : _colors.uBlack
                        buttonDisabledColor: _colors.uWhite
                        buttonDisabledTextColor: _colors.uMediumLightGrey


                        anchors.verticalCenter: parent.verticalCenter

                        iconId: "Download"
                        iconSize: 12

                        width: 20
                        height: 20

                        anchors.right: deleteBtn.left
                        anchors.rightMargin: 10

                        function execute() {
                            if (!canMoveDown)
                                return

                            var pScenario = taskModel.scenario
                            pScenario.moveTask(index, index + 1)
                        }
                    }

                    UI.UButton {
                        id: deleteBtn

                        buttonColor: _colors.uWhite
                        buttonHoveredColor: _colors.uMediumLightGrey
                        buttonTextColor : _colors.uBlack
                        buttonDisabledColor: _colors.uWhite
                        buttonDisabledTextColor: _colors.uMediumLightGrey

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

                        Component.onCompleted: {
                            if (index === taskList.count - 1)
                                state = "DISABLED"
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
