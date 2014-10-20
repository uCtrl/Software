import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel

Rectangle {
    id: listItem

    property variant item: null

    width: parent.width
    height: 42

    color: getColor()

    Rectangle {
        id: iconFrame

        width: 32; height: 32
        radius: 4

        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter

        color: "#0D9B0D"

        // @TODO : Replace with proper icon when ready.
        UI.UFontAwesome {
            id: iconLabel

            anchors.centerIn: iconFrame

            iconId: "Bolt"
            iconSize: 24
            iconColor: "white"
        }
    }

    UI.UFontAwesome {
        id: itemChevron

        width: 30

        anchors.right: parent.right
        anchors.rightMargin: 5

        anchors.verticalCenter: parent.verticalCenter

        iconId: "ChevronRight"
        iconSize: 22
        iconColor: "#D4D4D4"
    }

    ULabel.Default {
        text: getName()

        color: "black"

        font.bold: true
        font.pointSize: 18

        anchors.verticalCenter: iconFrame.verticalCenter

        anchors.left: iconFrame.right
        anchors.leftMargin: 10

        anchors.right: itemChevron.left
        anchors.rightMargin: 10
    }

    Rectangle {
        width: parent.width
        height: 1

        color: "#D4D4D4"

        anchors.bottom: parent.bottom
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
    }

    function getColor() {
        if (mouseArea.containsMouse) return "#EDEDED"
        else return "white"
    }

    function getName() {
        if (item != null) return item.name
        else return "Device name"
    }
}
