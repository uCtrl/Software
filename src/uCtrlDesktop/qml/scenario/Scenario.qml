import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../task" as Task
import "../ui/UColors.js" as Colors

Rectangle
{
    id: scenarioContainer

    property var model: null
    property bool showEditMode: false
    property var editTaskFunction

    anchors.fill: parent
    color: Colors.uTransparent

    Task.Tasks {
        id: tasksContainer

        width: parent.width
        anchors.top: parent.top
        anchors.bottom: footerContainer.top

        showEditMode: scenarioContainer.showEditMode
        editTaskFunction: scenarioContainer.editTaskFunction

        model: getTasks()
    }

    Rectangle
    {
        id: footerContainer

        width: parent.width

        anchors.bottom: parent.bottom
        clip: true

        height: !isActiveScenario() ? 30 : 0

        UI.UButton
        {
            id: createScenarioButton
            text: "Create new scenario"
            iconId: ""
            iconSize: 12
            width: 225
            anchors.verticalCenter: parent.verticalCenter
        }
        UI.UButton
        {
            id: createTaskButton
            text: "Create new task"
            iconId: ""
            iconSize: 12
            width: 225
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: createScenarioButton.right
            anchors.leftMargin: 10

            visible: showEditMode
        }
    }

    function getTasks() {
        if (model !== null && model !== undefined && scenarios !== undefined) return scenarios.model.nestedModelFromId(model.id)
    }

    function isActiveScenario()
    {
        return false
    }
}
