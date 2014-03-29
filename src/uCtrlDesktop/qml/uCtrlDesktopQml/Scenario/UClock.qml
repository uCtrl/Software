import QtQuick 2.0
import "../UI" as UI

Rectangle {
    property int clockHour: 12
    property int clockMinute: 00

    width: parent.height
    height: parent.height
    radius: width * 0.5
    color: _colors.uWhite

    Image {
        anchors.centerIn: parent

        height: parent.width
        width: parent.height

        source: "qrc:///Resources/Images/Clock-Icon.png"
    }

    Rectangle {
        id: clockHandContainer

        anchors.centerIn: parent
        width: 0
        height: 0
        color: _colors.uTransparent

        UI.ULine {
            id: shortClockHand

            lineLength: parent.parent.width * 0.25
            rotationDegrees: {
                var regHour = clockHour
                if(regHour >= 12)
                    regHour -= 12
                var angle = (regHour / 12.0 * 360) + (clockMinute / 60.0 * 360 / 12.0)  - 90;
                return angle;
            }
            color: _colors.uDarkGreen
            thickness: 2
        }
        UI.ULine {
            id: longClockHand

            lineLength: parent.parent.width * 0.45
            rotationDegrees: {
                var angle = clockMinute / 60.0 * 360 - 90;
                return angle;
            }
            color: _colors.uDarkGreen
            thickness: 2
        }
    }
}
