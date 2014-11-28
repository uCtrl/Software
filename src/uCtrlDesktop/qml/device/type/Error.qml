import QtQuick 2.0

import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    anchors.centerIn: parent

    ULabel.Default {
        anchors.centerIn: parent

        font.bold: true
        font.pointSize: 24(resourceLoader.loadResource("errorContainerParentFontPointSize"))

        color: Colors.uRed

        text: "Unknown device found"
    }
}
