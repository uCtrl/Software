import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

import DeviceEnums 1.0

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

        color: getStatusColor()

        DeviceIcon
        {
            deviceType: listItem.item === null ? 0 : listItem.item.type

            iconSize: 16
            iconColor: Colors.uWhite
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
        iconColor: Colors.uMediumLightGrey
    }

    ULabel.Description {
        text: getName()

        color: Colors.uBlack

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

        color: Colors.uMediumLightGrey

        anchors.bottom: parent.bottom
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
    }

    function getColor() {
        if (mouseArea.containsMouse) return Colors.uLightGrey
        else return Colors.uWhite
    }

    function getName() {
        if (item != null) return item.name
        else return "Device name"
    }

    function getStatusColor()
    {
        if(item !== null)
        {
            switch(item.status)
            {
            case 0:
                return Colors.uGreen; //OK
            case 1:
                return Colors.uYellow; //Disconnected
            case 2:
                return Colors.uRed; //Warning
            }
        }

        return Colors.uRed
    }
}
