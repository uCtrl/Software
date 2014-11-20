import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors
import ConditionEnums 1.0


Rectangle {
    id: conditionItemContainer

    property bool showEditMode: false

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
                iconColor: Colors.uMediumDarkGrey
                anchors.left: parent.left
            }

            ULabel.ConditionLabel {
                id: dateConditionText
                anchors.left: dateConditionIcon.right
                anchors.verticalCenter: parent.verticalCenter

                text: "Date is "
            }

            Loader {
                id: conditionContentLoader

                anchors.left: dateConditionText.right
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
                iconColor: Colors.uMediumDarkGrey
                anchors.left: parent.left
            }

            ULabel.ConditionLabel {
                id: timeConditionText
                anchors.left: timeConditionIcon.right
                anchors.verticalCenter: parent.verticalCenter

                text: "Time is "
            }

            Loader {
                id: conditionContentLoader

                anchors.left: timeConditionText.right
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
                iconColor: Colors.uMediumDarkGrey
                anchors.left: parent.left
            }

            ULabel.ConditionLabel {
                id: dayConditionText
                anchors.left: dayConditionIcon.right
                anchors.verticalCenter: parent.verticalCenter

                text: "Day is "
            }

            Loader {
                id: conditionContentLoader

                anchors.left: dayConditionText.right
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
                iconColor: Colors.uMediumDarkGrey
                anchors.left: parent.left
            }

            ULabel.ConditionLabel {
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

        ULabel.ConditionLabel {
            text: "greater than " + model.endValue
        }
    }

    Component {
        id: ltComponent

        ULabel.ConditionLabel {
            text: "lesser than " + model.beginValue
        }
    }

    Component {
        id: equalsComponent

        ULabel.ConditionLabel {
            text: "equal to " + model.beginValue
        }
    }

    Component {
        id: inBetweenComponent

        ULabel.ConditionLabel {
            text: "between " + model.beginValue + " and " + model.endValue
        }
    }

    Component {
        id: notComponent

        ULabel.ConditionLabel {
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
