import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors
import ConditionEnums 1.0


Rectangle {
    id: conditionItemContainer

    property bool showEditMode: false

    property var parseValue: doNotParseValue

    width: parent !== null ? parent.width : 100
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

            Component.onCompleted: {
                conditionItemContainer.parseValue = getDateLabel
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

            Component.onCompleted: {
                conditionItemContainer.parseValue = getTimeLabel
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

                text: getDayLabel(model.beginValue)
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

                text: "Device \"" + getDeviceName(model.deviceId) + "\" is "
            }

            Loader {
                id: conditionContentLoader

                anchors.left: deviceConditionText.right
                anchors.verticalCenter: parent.verticalCenter
                sourceComponent: getContentComponent()
            }

            Component.onCompleted: {
                conditionItemContainer.parseValue = doNotParseValue
            }
        }
    }

    Component {
        id: gtComponent

        ULabel.ConditionLabel {
            text: "greater than " + convertToReadableValues(conditionItemContainer.parseValue(model.beginValue))
        }
    }

    Component {
        id: ltComponent

        ULabel.ConditionLabel {
            text: "less than " + convertToReadableValues(conditionItemContainer.parseValue(model.endValue))
        }
    }

    Component {
        id: equalsComponent

        ULabel.ConditionLabel {
            text: "equal to " + convertToReadableValues(conditionItemContainer.parseValue(model.beginValue))
        }
    }

    Component {
        id: inBetweenComponent

        ULabel.ConditionLabel {
            text: "between " + convertToReadableValues(conditionItemContainer.parseValue(model.beginValue)) + " and " + convertToReadableValues(conditionItemContainer.parseValue(model.endValue))
        }
    }

    Component {
        id: notComponent

        ULabel.ConditionLabel {
            text: "not equal to " + convertToReadableValues(conditionItemContainer.parseValue(model.beginValue))
        }
    }

    function getDeviceName(deviceId)
    {
        if (devicesList.findObject(deviceId) !== null) return devicesList.findObject(deviceId).name()
        else return ""
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

    function getTimeLabel(value)
    {
        var minute = (value % 3600) / 60
        var hour = (value - (value % 3600)) / 3600

        return pad(hour, 2) + ":" + pad(minute, 2)

    }

    function pad(num, size) {
        var s = "000000000" + num;
        return s.substr(s.length-size);
    }

    function getDateLabel(value)
    {
        return Qt.formatDateTime(new Date(parseInt(value)), "dd-MM-yyyy")
    }

    function getDayLabel(value)
    {
        switch(value)
        {
            case "0":
                return "Never"
            case "62":
                return "During the week"
            case "65":
                return "During the weekend"
            case "127":
                return "Everyday"
            default:
                var valueLabels = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
                var valueActive = [value & 1, value & 2, value & 4, value & 8, value & 16, value & 32, value & 64]

                var label = ""
                for(var i = 0; i < valueActive.length; i++)
                {
                    if(valueActive[i])
                        label += valueLabels[i] + ", "
                }
                label = label.substring(0, label.length - 2)
                var lastCommaSpace = label.lastIndexOf(", ")

                if(lastCommaSpace === -1)
                    return label
                else
                    return label.substring(0, lastCommaSpace) + " and " + label.substring(lastCommaSpace + 2, label.length)
        }
    }

    function doNotParseValue(value)
    {
        return value
    }

    function convertToReadableValues(value)
    {
        return value.replace("true", "ON").replace("false", "OFF")
    }
}
