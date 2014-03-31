import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {
    property string text: "UNKNOWN"
    anchors.leftMargin: 8
    width: 200
    height: 40
    color: _colors.uTransparent

    UFontAwesome {
        id: triangle
        iconId: "CaretLeft"
        iconColor: _colors.uDarkGrey
        iconSize: 16
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: tooltip
        width: parent.width - triangle.width
        height: parent.height
        color: _colors.uDarkGrey
        radius: 5
        anchors.left: triangle.right
        anchors.verticalCenter: parent.verticalCenter

        ULabel.Default {
            text: parent.parent.text
            anchors.centerIn: parent
            color: _colors.uWhite
        }
    }
}
