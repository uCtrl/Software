import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: container

    property var item: null

    height: 30

    color: Colors.uWhite

    border.width: 1
    border.color: Colors.uLightGrey

    ULabel.Default {
        id: typeLabel

        text: getType()

        anchors.left: parent.left
        anchors.leftMargin: 5

        anchors.verticalCenter: parent.verticalCenter

        color: Colors.uGreen
    }

    function getType() {
        if (item !== null) return item.type
        else return 0
    }
}
