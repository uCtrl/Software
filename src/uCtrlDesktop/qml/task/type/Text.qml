import QtQuick 2.0

import "../../ui" as UI
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    color: Colors.uTransparent

    property var model

    UI.UTextbox {
        id: valueTextbox
        width: 130
        height: 40
        placeholderText: "Value"
        anchors.centerIn: parent
        text: model.value()

        function validate() {
            return text !== "";
        }

        state: validate() ? "SUCCESS" : "ERROR"

        onTextChanged: model.value(text);
    }
}
