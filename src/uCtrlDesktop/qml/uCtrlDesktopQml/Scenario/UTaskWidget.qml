import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Item {
    property var taskModel: taskList.model.getTaskAt(index)

    width: parent.width
    height: 40 + conditionsContainer.adjustedHeight()

    function toggleTasks() {
        conditionsContainer.visible = !conditionsContainer.visible
        toggleBtn.text = conditionsContainer.visible ? "-" : "+"
        height = 40 + conditionsContainer.adjustedHeight()
    }

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

            UI.UButton {
                id: toggleBtn

                anchors.verticalCenter: parent.verticalCenter

                text: "-"

                width: 20
                height: 20

                anchors.right: parent.right
                anchors.rightMargin: 10

                function execute() {
                    toggleTasks()
                }
            }

            UI.UIconButton {
                id: deleteBtn

                anchors.verticalCenter: parent.verticalCenter

                text: "Remove"
                iconSize: 12

                width: 20
                height: 20

                anchors.right: toggleBtn.left
                anchors.rightMargin: 10

                function execute() {
                    var pScenario = taskModel.scenario
                    pScenario.deleteTaskAt(index)
                }
            }

            UI.UIconButton {
                id: moveDown

                anchors.verticalCenter: parent.verticalCenter

                text: "ArrowDown"
                iconSize: 10

                width: 20
                height: 20

                anchors.right: deleteBtn.left
                anchors.rightMargin: 10

                function execute() {
                    var pScenario = taskModel.scenario
                    pScenario.moveTask(index, index + 1)
                }
            }

            UI.UIconButton {
                id: moveUp

                anchors.verticalCenter: parent.verticalCenter

                text: "ArrowUp"
                iconSize: 10

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
                id: addConditionBtn

                anchors.verticalCenter: parent.verticalCenter

                text: "A"

                width: 20
                height: 20

                anchors.right: moveUp.left
                anchors.rightMargin: 10

                function execute() {
                    var pCondition = taskModel.createCondition()
                    taskModel.addCondition(pCondition)
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

                delegate: UTaskConditionWidget { }
            }
        }
    }
}
