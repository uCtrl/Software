import QtQuick 2.0

import "../UI" as UI
import ConditionEnums 1.0

Rectangle {
    id: container

    property var conditionModel: taskModel.getConditionAt(index)
    property bool isConditionOfTask: true
    property bool isEditMode: false

    width: parent.width
    height: 35

    color: _colors.uTransparent

    function saveCondition() {
        conditionLoader.saveCondition()
    }

    function cancelEditCondition() {
        conditionLoader.cancelEditCondition()
    }

    Rectangle {
        id: conditionContent
        anchors.right: deleteBtn.left
        anchors.fill: parent
        width: parent.width
        height: parent.height

        Loader {
            property var saveConditionFunc: function(){}
            property var cancelEditConditionFunc: function(){}

            id: conditionLoader

            anchors.fill: parent
            sourceComponent: getSourceComponent()

            function getSourceComponent() {
                switch(conditionModel.type) {
                case UEConditionType.Date:
                    return uDateComponent
                case UEConditionType.Time:
                    return uTimeComponent
                case UEConditionType.Day:
                    return uWeekdayComponent
                case UEConditionType.Device:
                    return uDeviceComponent
                default:
                    return
                }
            }

            function saveCondition() {
                saveConditionFunc()
            }

            function cancelEditCondition() {
                cancelEditConditionFunc()
            }
        }

        Component {
            id: uTimeComponent

            UTimeConditionWidget {
                id: uTimeConditionWidget

                isEditMode: container.isEditMode

                Component.onCompleted: {
                    conditionLoader.saveConditionFunc = function() {
                        saveCondition()
                    }

                    conditionLoader.cancelEditConditionFunc = function() {
                        updateConditionView()
                    }
                }
            }
        }

        Component {
            id: uDateComponent
            UDateConditionWidget {
                isEditMode: container.isEditMode

                Component.onCompleted: {
                    conditionLoader.saveConditionFunc = function() {
                        saveCondition()
                    }

                    conditionLoader.cancelEditConditionFunc = function() {
                        updateConditionView()
                    }
                }
            }
        }

        Component {
            id: uWeekdayComponent
            UWeekdayConditionWidget {
                id: uWeekdayConditionWidget

                weekDayCondition: conditionModel
                isEditMode: container.isEditMode

                Component.onCompleted: {
                    conditionLoader.saveConditionFunc = function() {
                        saveCondition()
                    }

                    conditionLoader.cancelEditConditionFunc = function() {
                        cancelEditCondition()
                    }
                }
            }
        }

        Component {
            id: uDeviceComponent
            UDeviceConditionWidget {
                id: uDeviceConditionWidget

                deviceCondition: conditionModel
                isEditMode: container.isEditMode

                Component.onCompleted: {
                    conditionLoader.saveConditionFunc = function() {
                        saveCondition()
                    }

                    conditionLoader.cancelEditConditionFunc = function() {
                        cancelEditCondition()
                    }
                }
            }
        }
    }

    UI.UButton {
        id: deleteBtn

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 10

        width: 20
        height: 20

        buttonColor: _colors.uWhite
        buttonHoveredColor: _colors.uMediumLightGrey
        buttonTextColor : _colors.uBlack

        visible: isEditMode
        iconId: "Remove"
        iconSize: 12

        function execute() {
            if (isConditionOfTask) {
                taskModel.deleteConditionAt(index)
            }
        }
    }
}





