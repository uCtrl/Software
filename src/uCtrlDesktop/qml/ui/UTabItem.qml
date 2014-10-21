import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "UColors.js" as Colors

Rectangle {

    id: container

    property string iconColor: Colors.get("uWhite")
    property string iconId: ""
    property string linkText: ""

    property bool showText: false

    Rectangle {
        id: toBeCentered

        anchors.centerIn: parent
        height: parent.height; width: icon.width + link.width + 20

        color: Colors.get("uTransparent")

        UI.UFontAwesome {
            id: icon

            anchors.left: parent.left
            anchors.leftMargin: 5

            anchors.verticalCenter: parent.verticalCenter

            iconId: container.iconId
            iconColor: container.iconColor
            iconSize: 12
        }

        ULabel.Link {
            id: link

            visible: showText

            anchors.left: icon.right
            anchors.leftMargin: 13

            anchors.verticalCenter: parent.verticalCenter

            text: container.linkText

            color: Colors.get("uWhite")
        }
    }
}
