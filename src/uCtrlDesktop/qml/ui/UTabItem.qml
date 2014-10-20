import QtQuick 2.0

import "../ui" as UI

Rectangle {

    id: container

    property string iconColor: "white"
    property string iconId: ""

    UI.UFontAwesome {
        id: icon

        anchors.centerIn: container

        iconId: container.iconId
        iconColor: container.iconColor
        iconSize: 12
    }
}
