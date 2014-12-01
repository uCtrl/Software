import QtQuick 2.0

import "../../ui" as UI
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    color: Colors.uTransparent

    property var model
    UI.USwitch {
        id: valueTextbox
        width: 100
        height: 30

        onValueLabel: "UP"
        offValueLabel: "DOWN"

        anchors.centerIn: parent
        Component.onCompleted: {
            taskEditorContainer.saveConditions.connect(saveState)

            state = (model.value() === "1" ? "ON" : "OFF")
        }

        function saveState()
        {
            model.value((state === "ON" ? 1 : 0))
        }
    }
}
