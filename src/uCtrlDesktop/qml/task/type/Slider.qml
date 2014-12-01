import QtQuick 2.0

import "../../ui" as UI
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    property var model

    width: 130

    Rectangle
    {
        property int textWidth: 50

        anchors.left: parent.left
        anchors.leftMargin: textWidth

        width: 130 - textWidth
        height: 40

        UI.USlider {
            id: valueTextbox
            width: parent.width
            height: 40
            textWidth: parent.textWidth
            textSize: 12

            minimumValue: 0
            maximumValue: 100
            stepSize: 1

            anchors.centerIn: parent

            value: model.value() * 100

            onNewValue: model.value(value / 100)
        }
    }
}
