import QtQuick 2.0

Rectangle {
    property string labelText: "UNKNOWN"

    color: colors.uGreen
    radius: 5

    ULabel {
        id: buttonLabel
        anchors.centerIn: parent
        text: labelText
        color: "white"
        font.bold: true
    }
}
