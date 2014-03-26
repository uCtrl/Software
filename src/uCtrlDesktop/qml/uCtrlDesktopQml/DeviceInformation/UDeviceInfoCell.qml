import QtQuick 2.0
import "../UI" as UI


Rectangle {
    property string title: "DEFAULT TITLE"

    width: 510
    height: 30
    color: _colors.uTransparent

    Rectangle {
        id: infoPaddinLeft
        width: 10
        height: parent.height
        anchors.left: parent.left
        color: _colors.uTransparent
    }

    UI.ULabel {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: infoPaddinLeft.right
        text: title
    }
}