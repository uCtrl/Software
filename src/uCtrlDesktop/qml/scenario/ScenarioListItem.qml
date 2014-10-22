import QtQuick 2.0

import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {

    id: listItem

    property var item: null

    property string scenarioName: "Scenario name"
    property int marginSize: 10

    width: parent.width
    height: parent.height

    color: getColor()

    ULabel.Default {
        id: indexLabel

        x: marginSize; y: marginSize

        text: (index + 1) + ". "

        color: Colors.uBlack

        font.bold: true
        font.pointSize: 16
    }

    ULabel.Default {
        id: scenarioNameText

        anchors.left: indexLabel.right
        anchors.leftMargin: 10

        anchors.right: parent.right

        anchors.verticalCenter: indexLabel.verticalCenter

        text: getName()

        color: Colors.uBlack

        font.bold: true
        font.pointSize: 16

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
        if (item !== null) return item.name
        else return "Scenario name"
    }
}
