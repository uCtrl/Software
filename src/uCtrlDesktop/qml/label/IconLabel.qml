import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors

Rectangle {
    id: iconLabel
    width: 100
    height: 30

    property string iconId: "UNKNOWN"
    property int iconLabelSize: 10
    property int iconSize: 9
    property string iconLabelColor: Colors.uGreen
    property string text: "UNKNOWN"

    Rectangle
    {
        anchors.left: parent.left
        anchors.leftMargin: 5
        width: labelIcon.width + labelText.width + 50
        height: parent.height
        color: Colors.uTransparent

        UI.UFontAwesome {
            id: labelIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 7

            iconColor: iconLabel.iconLabelColor
            iconSize: iconLabel.iconSize
            iconId: iconLabel.iconId
        }

        Default {
            id: labelText

            anchors.left: labelIcon.right
            anchors.leftMargin: 13

            anchors.verticalCenter: parent.verticalCenter

            text: iconLabel.text

            font.bold: false
            font.pointSize: iconLabel.iconLabelSize

            color: iconLabel.iconLabelColor
        }
    }
}
