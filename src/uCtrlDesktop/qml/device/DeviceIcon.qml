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
            case UEType.PushButton:
                return "ToggleOn"
            case UEType.MotionSensor:
                return "Bolt"
            case UEType.Humidity:
                return "droplet"
            case UEType.Temperature:
                return "thermometer"
            case UEType.NinjasEyes:
                return "EyeOpen"
            case UEType.LimitlessLEDWhite:
                return "Lightbulb"
            case UEType.DoorSensor:
                return "Key"
            case UEType.LightSensor:
                return "Bolt"
            case UEType.FlowSwitch:
                return "ToggleOn"
            case UEType.ColorPanel:
                return "Bolt"
            default:
                return "QuestionMark"
        }
    }
}
