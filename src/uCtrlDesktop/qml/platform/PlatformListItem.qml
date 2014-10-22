import QtQuick 2.0

import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {

    id: listItem

    property var item: null

    property string platformName: "Platform name"
    property int marginSize: 10

    width: parent.width
    height: parent.height

    color: getColor()

    ULabel.Default {
        id: platformNameText

        x: marginSize; y: marginSize

        text: getName()

        color: Colors.uBlack

        font.bold: true
        font.pointSize: 16
    }

    ULabel.Default {
        id: platformUpdateText

        x: marginSize
        anchors.top: platformNameText.bottom

        text: "Updated a second ago."

        color: Colors.uMediumDarkGrey

        font.pixelSize: 11
    }

    Rectangle {
        id: platformSeparator

        width: parent.width
        height: 1

        anchors.bottom: parent.bottom

        color: Colors.uMediumLightGrey
    }

    function getColor() {
        if (mouseArea.containsMouse) return Colors.uLightGrey
        else return Colors.uWhite
    }

    function getName() {
        if (item != null) return item.name
        else return "Platform name"
    }
}
