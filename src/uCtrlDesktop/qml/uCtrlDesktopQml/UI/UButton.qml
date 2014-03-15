import QtQuick 2.0

Rectangle {
    property string label: "UNKNOWN"

    color: colors.uGreen
    radius: 5

    border.color: colors.uDarkGreen
    border.width: 1

    ULabel {
        id: buttonLabel
        anchors.centerIn: parent
        text: label
        color: "white"
        font.bold: true
    }
}
