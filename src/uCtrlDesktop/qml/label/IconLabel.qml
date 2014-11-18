import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors

Rectangle {
    id: iconLabel
    width: 100
    height: 30

    property string iconId: "UNKNOWN"
    property int iconLabelSize: 10
    property string iconLabelColor: Colors.uGreen
    property string text: "UNKNOWN"

    Rectangle
    {
        anchors.left: parent.left
        anchors.leftMargin: 5
        width: parent.width
        height: parent.height
        color: Colors.uTransparent

        UI.UFontAwesome {
            id: labelIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10

            iconColor: iconLabel.iconLabelColor
            iconSize: iconLabel.iconLabelSize * 1.4
            iconId: iconLabel.iconId
        }

        Default {
            id: labelText

            anchors.left: labelIcon.right
            anchors.leftMargin: 15

            anchors.verticalCenter: parent.verticalCenter

            text: iconLabel.text

            font.bold: true
            font.pointSize: iconLabel.iconLabelSize

            color: iconLabel.iconLabelColor
        }
    }
}
