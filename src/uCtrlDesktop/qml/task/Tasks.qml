import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: tasksList

    property var model: null

    ListView {
        id: tasks
        anchors.fill: parent
        model: tasksList.model
        clip:true
        delegate: Task {
            item: model
        }
    }
}
