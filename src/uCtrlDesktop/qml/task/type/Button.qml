import QtQuick 2.0

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    property var model

    color: Colors.uTransparent

    ULabel.UInfoBoundedLabel {
        id: valueTextbox

        boundedHeight: 5
        boundedWidth: 5
        boundedColor: Colors.uGreen
        boundedTextSize: 36

        anchors.centerIn: parent

        text: "ON"
    }

    Component.onCompleted: model.value(true)
}
