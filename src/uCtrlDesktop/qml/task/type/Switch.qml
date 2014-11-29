import QtQuick 2.0

import "../../ui" as UI
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    color: Colors.uTransparent

    property var model
    UI.USwitch {
        id: valueTextbox
        width: 130
        height: 40

        anchors.centerIn: parent
        state: (model.value() ? "ON" : "OFF")

        function validate() {
            return text !== "";
        }

        onStateChanged: model.value((state === "ON"));
    }
}
