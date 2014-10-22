import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {

    id: tasksList

    property var model: null

    ListView {
        id: tasks

        model: tasksList.model

        anchors.top: tasksList.top
        anchors.bottom: tasksList.bottom

        anchors.left: tasksList.left
        anchors.right: tasksList.right

        delegate: Column {
            id: column

            width: parent.width

            Task {
                id: itemContainer

                width: parent.width

                item: model

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
        }
    }
}
