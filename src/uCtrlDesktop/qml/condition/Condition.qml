import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

import DeviceEnums 1.0 as DeviceEnums
import ConditionEnums 1.0

Rectangle {
    id: conditionItemContainer

    property bool showEditMode: false

    width: parent !== null ? parent.width : 100
    height: 30

            UI.UFontAwesome {
        id: conditionIcon

                width: 30
                anchors.verticalCenter: parent.verticalCenter

        iconId: getConditionIcon()
                iconSize: 16
                iconColor: Colors.uMediumDarkGrey
                anchors.left: parent.left
            }

            ULabel.ConditionLabel {
                id: dateConditionText
        anchors.left: conditionIcon.right
                anchors.verticalCenter: parent.verticalCenter

        text: getConditionLabel()
            }

    function getConditionIcon()
    {
        switch(model.type)
        {
            case UEType.Date:
                return "Calendar"
            case UEType.Day:
                return "CalendarEmpty"
            case UEType.Time:
                return "clock"
            case UEType.Device:
                return "Bolt"
            default:
                return "QuestionMark"
        }
    }

    function getConditionLabel()
    {
        switch(model.type)
        {
            case UEType.Date:
                return "When date is " + getValueString(getDateLabel)
            case UEType.Day:
                return getDayLabel(model.beginValue)
            case UEType.Time:
                return "When time is "  + getValueString(getTimeLabel)
            case UEType.Device:
                var deviceValueType = getDeviceValueType(model.deviceId)
                switch(deviceValueType)
                {
                    case DeviceEnums.UEValueType.Event:
                        return "When device \"" + getDeviceName(model.deviceId) + "\" fires an event"
                    case DeviceEnums.UEValueType.Switch:
                        return "When device \"" + getDeviceName(model.deviceId) + "\" is " + (model.beginValue === "1" ? "ON" : "OFF")
                    case DeviceEnums.UEValueType.Slider:
                        return "When device \"" + getDeviceName(model.deviceId) + "\" is " + getValueString(getSliderLabel)
                    default:
                        return "When device \"" + getDeviceName(model.deviceId) + "\" is " + getValueString(getLabel)
        }
            default:
                return "Unknown condition"
        }
    }

    function getDeviceName(deviceId)
    {
        if (devicesList.findObject(deviceId) !== null) return devicesList.findObject(deviceId).name()
        else return ""
    }

    function getDeviceValueType(deviceId)
    {
        if (devicesList.findObject(deviceId) !== null) return devicesList.findObject(deviceId).valueType()
        else return ""
    }

    function getValueString(parseValueFunction)
    {
        switch(model.comparisonType)
        {
        case UEComparisonType.GreaterThan:
                return "greater than " + parseValueFunction(model.beginValue)
        case UEComparisonType.LesserThan:
                return "less than " + parseValueFunction(model.endValue)
        case UEComparisonType.Equals:
                return "equal to " + parseValueFunction(model.beginValue)
        case UEComparisonType.InBetween:
                return "between " + parseValueFunction(model.beginValue) + " and " + parseValueFunction(model.endValue)
        case UEComparisonType.Not:
                return "not equal to " + parseValueFunction(model.beginValue)
        }
    }

    function getTimeLabel(value)
    {
        var minute = (value % 3600) / 60
        var hour = (value - (value % 3600)) / 3600

        return pad(hour, 2) + ":" + pad(minute, 2)
    }

    function getSliderLabel(value)
    {
        return Math.round(value * 100)
    }

    function getLabel(value)
    {
        return value
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
                    return "On " + label
                else
                    return "On " + label.substring(0, lastCommaSpace) + " and " + label.substring(lastCommaSpace + 2, label.length)
        }
    }
}
