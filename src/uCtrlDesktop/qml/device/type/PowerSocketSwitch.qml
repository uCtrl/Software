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

        UI.USwitch {
            property int marginSize: 5

            id: triggerButton

            anchors.centerIn: buttonContainer

            height: buttonContainer.height - (2 * marginSize); width: 110

            state: "ON"
        }

        height: 45; width: 100
    }

    Sensor {
        property var model: container.model

        anchors.top: buttonContainer.bottom
        anchors.left: container.left
        anchors.right: container.right
        anchors.bottom: container.bottom
    }

    function sendAction() {
        model.value = true
        uCtrlApiFacade.putDevice(devicesList.findObject(model.id))
    }
}
