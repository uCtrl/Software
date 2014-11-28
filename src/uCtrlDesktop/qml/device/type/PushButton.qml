import QtQuick 2.0

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

Rectangle {

    id: container
    property var model: null

    Sensor {
        model: container.model
        anchors.fill: parent
    }
}
