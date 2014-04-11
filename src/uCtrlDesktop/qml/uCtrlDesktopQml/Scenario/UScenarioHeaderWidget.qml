import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    function refresh(newName) {
        scenarioNameLabel.text = newName
    }

    width: parent.width
    height: 30

    color: _colors.uUltraLightGrey

    ULabel.Default {
        id: scenarioNameLabel
        color: _colors.uDarkGrey
        font.pointSize: 11
        font.bold: true

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}
