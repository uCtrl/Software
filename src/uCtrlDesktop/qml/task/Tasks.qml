import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: tasksList

    property var model: null
    property bool showEditMode: false
    property var editTaskFunction

    ListView {
        id: tasks
        anchors.fill: parent
        model: tasksList.model
        clip:true
        spacing: 10
        delegate: Task {
            item: model
            editTaskFunction: tasksList.editTaskFunction
            showEditMode: tasksList.showEditMode
        }
    }
}
