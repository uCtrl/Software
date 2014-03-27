import QtQuick 2.0
import "../UI" as UI

Rectangle {
    property string scenarioName: "UNKNOWN SCENARIO NAME"

    function refresh(newName) {
        scenarioName = newName
    }

    width: parent.width
    height: 30

    color: _colors.uUltraLightGrey

    UI.ULabel {
        text: scenarioName
        color: _colors.uDarkGrey
        font.pointSize: 11
        font.bold: true

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }

    Rectangle {
        height: 20
        width: 25

        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 10

        radius: 5
        color: _colors.uTransparent
    }
}
