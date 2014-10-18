import QtQuick 2.0

import "../label" as ULabel

Rectangle {

    id: listItem

    property string platformName: "Platform name"
    property int marginSize: 10

    width: parent.width
    height: parent.height

    color: getColor()

    ULabel.Default {
        id: platformNameText

        x: marginSize; y: marginSize

        text: platformName

        color: "black"

        font.bold: true
        font.pointSize: 16
    }

    ULabel.Default {
        id: platformUpdateText

        x: marginSize
        anchors.top: platformNameText.bottom

        text: "Updated a second ago."

        color: "#737373"

        font.pixelSize: 11
    }

    Rectangle {
        id: platformSeparator

        width: parent.width
        height: 1

        anchors.bottom: parent.bottom

        color: "#D4D4D4"
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true

        onClicked: {
            platformInfo.model = model
            platforms.currentIndex = index
        }
    }

    function getColor() {
        if (mouseArea.containsMouse) return "#EDEDED"
        else return "white"
    }
}
