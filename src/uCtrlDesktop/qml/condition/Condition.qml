import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors
import ConditionEnums 1.0


Rectangle {
    id: conditionItemContainer
    width: parent.width
    height: 30

    Loader {
        id: conditionLoader

        anchors.fill: parent
        sourceComponent: getSourceComponent()
    }

    Component {
        id: dateComponent

        Rectangle {
            anchors.fill: parent

            UI.UFontAwesome {
                id: dateConditionIcon

                width: 30
                anchors.verticalCenter: parent.verticalCenter

                iconId: "Calendar"
                iconSize: 16
                iconColor: Colors.uBlack
                anchors.left: parent.left
            }

            Loader {
                id: conditionContentLoader

                anchors.left: dateConditionIcon.right
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: getContentComponent()
            }
        }
    }

    Component {
        id: timeComponent

        Rectangle {
            anchors.fill: parent

            UI.UFontAwesome {
                id: timeConditionIcon

                width: 30
                anchors.verticalCenter: parent.verticalCenter

                iconId: "clock"
                iconSize: 16
                iconColor: Colors.uBlack
                anchors.left: parent.left
            }

            Loader {
                id: conditionContentLoader

                anchors.left: timeConditionIcon.right
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: getContentComponent()
            }
        }
    }

    Component {
        id: dayComponent

        Rectangle {
            anchors.fill: parent

            UI.UFontAwesome {
                id: dayConditionIcon

                width: 30
                anchors.verticalCenter: parent.verticalCenter

                iconId: "Calendar"
                iconSize: 16
                iconColor: Colors.uBlack
                anchors.left: parent.left
            }

            Loader {
                id: conditionContentLoader

                anchors.left: dayConditionIcon.right
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: getContentComponent()
            }
        }
    }

    Component {
        id: deviceComponent

        Rectangle {
            anchors.fill: parent

            UI.UFontAwesome {
                id: deviceConditionIcon

                width: 30
                anchors.verticalCenter: parent.verticalCenter

                iconId: "lightning"
                iconSize: 16
                iconColor: Colors.uBlack
                anchors.left: parent.left
            }

            ULabel.Default {
                id: deviceConditionText
                anchors.left: deviceConditionIcon.right
                anchors.verticalCenter: parent.verticalCenter

                text: "Device with id " + model.deviceId + " is "
            }

            Loader {
                id: conditionContentLoader

                anchors.left: deviceConditionText.right
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: getContentComponent()
            }
        }
    }

    Component {
        id: gtComponent

        ULabel.Default {
            text: "greater than " + model.endValue
        }
    }

    Component {
        id: ltComponent

        ULabel.Default {
            text: "lesser than " + model.beginValue
        }
    }

    Component {
        id: equalsComponent

        ULabel.Default {
            text: "equal to " + model.beginValue
        }
    }

    Component {
        id: inBetweenComponent

        ULabel.Default {
            text: "between " + model.beginValue + " and " + model.endValue
        }
    }

    Component {
        id: notComponent

        ULabel.Default {
            text: "not " + model.beginValue
        }
    }

    function getSourceComponent() {
        switch(model.type)  {
        case UEType.Date:
            return dateComponent;
        case UEType.Day:
            return dayComponent;
        case UEType.Time:
            return timeComponent;
        case UEType.Device:
            return deviceComponent;
        }
    }

    function getContentComponent() {
        switch(model.comparisonType)  {
        case UEComparisonType.GreaterThan:
            return gtComponent;
        case UEComparisonType.LesserThan:
            return ltComponent;
        case UEComparisonType.Equals:
            return equalsComponent;
        case UEComparisonType.InBetween:
            return inBetweenComponent;
        case UEComparisonType.Not:
            return notComponent;
        }
    }
}
