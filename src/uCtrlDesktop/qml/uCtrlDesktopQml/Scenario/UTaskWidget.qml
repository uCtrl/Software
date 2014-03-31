import QtQuick 2.0
import "../UI" as UI

Item {
    property var taskModel: taskList.model.getTaskAt(index)

    width: parent.width
    height: 40 + conditionsContainer.adjustedHeight()

    function toggleTasks() {
        conditionsContainer.visible = !conditionsContainer.visible
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

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 10

            width: parent.width - anchors.leftMargin
            height: 25

            UI.ULabel {
                id: changeStateLabel
                text: "Changer l'état pour "
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 14
                color: _colors.uDarkGrey
            }

            Rectangle {
                id: stateContainer
                color: _colors.uLightGrey

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: changeStateLabel.right
                anchors.leftMargin: 7
                anchors.rightMargin: 7

                width: stateLabel.width + 15
                height: parent.height - 5

                radius: 10

                UI.ULabel {
                    id: stateLabel
                    text: taskModel.status
                    anchors.centerIn: parent
                    font.pointSize: 12
                    font.bold: true
                }
            }

            UI.ULabel {
                id: stateLabelWhen

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: stateContainer.right
                anchors.leftMargin: 5

                text: "quand:"
                font.pointSize: 14
                color: _colors.uDarkGrey
            }

            UI.UButton {
                id: toggleBtn

                text: "T"

                width: 20
                height: 20

                anchors.right: parent.right
                anchors.rightMargin: 10

                function execute() {
                    toggleTasks()
                }
            }

            UI.UButton {
                id: deleteBtn

                text: "X"

                width: 20
                height: 20

                anchors.right: toggleBtn.left
                anchors.rightMargin: 10

                function execute() {
                    var pScenario = taskModel.scenario
                    pScenario.deleteTaskAt(index)
                }
            }

            UI.UButton {
                id: moveDown

                text: "D"

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
                id: moveUp

                text: "U"

                width: 20
                height: 20

                anchors.right: moveDown.left
                anchors.rightMargin: 10

                function execute() {
                    var pScenario = taskModel.scenario
                    pScenario.moveTask(index, index - 1)                }
            }
        }

        Rectangle {
            id: dragger

            anchors.right: parent.right
            height: parent.height
            width: 40

            color: _colors.uTransparent
            visible: conditionsContainer.adjustedHeight() > 0

            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                height: 30
                width: 30
                source: "qrc:///Resources/Images/drag.png"
            }
        }

        Rectangle {
            id: conditionsContainer
            clip: true

            height: 40 * conditionList.count
            width: parent.width - dragger.width

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
                delegate: UTimeConditionWidget {
                    conditionHour: 15
                    conditionMinute: 00
                }
            }
        }
    }
}
