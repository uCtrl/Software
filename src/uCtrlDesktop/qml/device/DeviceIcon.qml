import QtQuick 2.0

import "../ui" as UI
import DeviceEnums 1.0

UI.UFontAwesome {
    id: icon

    property var deviceType

    anchors.centerIn: parent

    iconId: getDeviceIcon()
    iconSize: 16
    iconColor: Colors.uWhite

    function getDeviceIcon()
    {
        switch(deviceType) {
            case UEType.PowerSocketSwitch:
                return "Plug"
            case UEType.BelkinWeMoSocket:
                return "Bolt"
            case UEType.Humidity:
                return "droplet"
            case UEType.Light:
                return "Lightbulb"
            case UEType.LightSensor:
                return "Bolt"
            case UEType.NinjasEyes:
                return "EyeOpen"
            case UEType.OnBoardRGBLed:
                return "Lightbulb"
            case UEType.PIRMotionSensor:
                return "Bolt"
            case UEType.ProximitySensor:
                return "Bolt"
            case UEType.PushButton:
                return "ToggleOn"
            case UEType.RF4333:
                return "Bolt"
            case UEType.StatusLight:
                return "Lightbulb"
            case UEType.Switch:
                return "ToggleOn"
            case UEType.Temperature:
                return "thermometer"
            case UEType.LimitlessLEDRGBW:
                return "Lightbulb"
            case UEType.LimitlessLEDWhite:
                return "Lightbulb"
            case UEType.LimitlessLEDRGBW2:
                return "Lightbulb"
            case UEType.DoorCaptor:
                return "Key"
            default:
                return ""
        }
    }
}
