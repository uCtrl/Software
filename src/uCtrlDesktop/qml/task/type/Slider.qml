import QtQuick 2.0

import "../../ui" as UI
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    color: Colors.uTransparent

    property var model
    UI.USlider {
        id: valueTextbox
        width: 130
        height: 40

        anchors.centerIn: parent

        value: model.value()

        onNewValue: model.value(value)
    }
}
