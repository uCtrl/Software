import QtQuick 2.0

Rectangle {
    property int clockHour: 12
    property int clockMinute: 00

    width: parent.height
    height: parent.height
    radius: width * 0.5
    color: "white"

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
        color: "transparent"

        ULine {
            id: shortClockHand
            lineLength: parent.parent.width * 0.25
            rotationDegrees: {
                var regHour = clockHour
                if(regHour >= 12)
                    regHour -= 12
                var angle = (regHour / 12.0 * 360) + (clockMinute / 60.0 * 360 / 12.0)  - 90;
                return angle;
            }
            color: "#14892C"
            thickness: 2
        }
        ULine {
            id: longClockHand
            lineLength: parent.parent.width * 0.45
            rotationDegrees: {
                var angle = clockMinute / 60.0 * 360 - 90;
                return angle;
            }
            color: "#14892C"
            thickness: 2
        }
    }


}
