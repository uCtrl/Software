import QtQuick 2.0

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

Rectangle {

    id: container
    property var model: null

    Rectangle {
        id: buttonContainer

        anchors.top: container.top
        anchors.left: container.left
        anchors.right: container.right

        color: Colors.uTransparent

        UI.UButton {
            property int marginSize: 10

            id: triggerButton

            iconId: "droplet"

            anchors.centerIn: buttonContainer

            height: buttonContainer.height - (2 * marginSize); width: height
        }

        height: 25
    }

    Sensor {
        property var model: container.model

        anchors.top: buttonContainer.bottom
        anchors.left: container.left
        anchors.right: container.right
        anchors.bottom: container.bottom
    }
}
