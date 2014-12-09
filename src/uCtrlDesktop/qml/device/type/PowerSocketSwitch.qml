import QtQuick 2.0

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

Rectangle {

    id: container
    property var model: null

    Rectangle {
        id: switchContainer

        anchors.top: container.top
        anchors.left: container.left
        anchors.right: container.right

        width: 100
        height: 45

        color: Colors.uTransparent

        UI.USwitch {
            property int marginSize: 5

            id: triggerButton

            anchors.centerIn: switchContainer

            width: 110
            height: parent.height - (2 * marginSize)

            state: (model.value === "1" ? "ON" : "OFF")

            onSwitchToggled: {
                console.log("SAVE: " + state)
                sendAction(state === "ON" ? "1" : "0")
            }
        }
    }

    Sensor {
        model: container.model

        anchors.top: switchContainer.bottom
        anchors.left: container.left
        anchors.right: container.right
        anchors.bottom: container.bottom

        hideButton: true
    }

    function sendAction(newValue) {
        model.value = newValue
        uCtrlApiFacade.putDevice(devicesList.findObject(model.id))
    }
}
