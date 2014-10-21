import QtQuick 2.0

import "../ui" as UI
import "UColors.js" as Colors

Rectangle {

    id: container

    property string iconColor: Colors.get("uWhite")
    property string iconId: ""

    UI.UFontAwesome {
        id: icon

        anchors.centerIn: container

        iconId: container.iconId
        iconColor: container.iconColor
        iconSize: 12
    }
}
