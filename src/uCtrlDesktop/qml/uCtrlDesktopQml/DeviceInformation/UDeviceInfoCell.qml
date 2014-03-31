import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel


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

    ULabel.Default {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: infoPaddinLeft.right
        text: title
    }
}
