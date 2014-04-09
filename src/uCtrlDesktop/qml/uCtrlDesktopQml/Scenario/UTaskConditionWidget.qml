import QtQuick 2.0

import "../UI" as UI

Rectangle {
    property var conditionModel: taskModel.getConditionAt(index)
    property bool isConditionOfTask: true
    property bool isEditMode: false

    width: parent.width
    height: 35

    color: _colors.uTransparent

    function saveCondition() {
        conditionLoader.saveCondition()
    }

    Rectangle {
        id: conditionContent
        anchors.right: deleteBtn.left
        anchors.fill: parent
        width: parent.width
        height: parent.height

        Loader {
            property var saveConditionFunc: function(){}

            id: conditionLoader

            anchors.fill: parent
            sourceComponent: getSourceComponent()

            function getSourceComponent() {
                var type = conditionModel.getTypeName()
                if (type === "Date")
                    return uDateComponent;
                if (type === "Time")
                    return uTimeComponent;
                else return;
            }

            function saveCondition() {
                //sourceComponent.saveCondition()
                saveConditionFunc()
                //sourceComponent.saveCondition()
            }
        }

        Component {
            id: uTimeComponent

            UTimeConditionWidget {
                id: uTimeConditionWidget

                timeCondition: conditionModel

                Component.onCompleted: {
                    conditionLoader.saveConditionFunc = function() {
                        saveCondition()
                    }
                }

            }


        }

        Component {
            id: uDateComponent
            UDateConditionWidget {
            }
        }
    }

    UI.UButton {
        id: deleteBtn

        text: "x"

        width: 20
        height: 20

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10

        function execute() {
            if (isConditionOfTask) {
                taskModel.deleteConditionAt(index)
            }
        }
    }
}





