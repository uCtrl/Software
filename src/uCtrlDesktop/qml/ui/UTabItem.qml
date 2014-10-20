import QtQuick 2.0

import "../ui" as UI

Rectangle {

    id: container

    property string iconColor: "white"
    property string iconId: ""

    radius: 8

    UI.UFontAwesome {
        id: icon

        anchors.centerIn: container

        iconId: container.iconId
        iconColor: container.iconColor
        iconSize: 12
    }
}
