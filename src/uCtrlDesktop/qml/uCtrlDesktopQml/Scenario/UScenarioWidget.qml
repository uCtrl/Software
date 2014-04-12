import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: scenarioWidget
    property string name: "UNKNOWN"
    property var scenario
    clip:true
    property bool isEditMode: false

    color: _colors.uWhite
    height: parent.height
    width: parent.width

    function cancelEditTasks() {
        taskList.cancelEditTasks()
    }

    function getName() {
        return (device === undefined || device === null ? "UNKNOWN" : device.name)
    }

    function getRoom() {
        return (device === undefined || device === null ? "UNKNOWN" : "UNKNOWN" /*device.room*/)
    }

    function getImagePath() {
        var imagePaths = [ "a", "b", "c", "d"]
        return imagePaths[(device === undefined || device === null ? 0 : device.type)]
    }

    function refresh(newScenario) {
        taskList.model = newScenario
    }

    Rectangle {
        id: scenarioTask
        clip:true

        anchors.top: parent.top
        anchors.bottom: addTaskButton.top

        width: parent.width

        color: _colors.uTransparent
        visible: true

        ListView {
            property var newTasks: []

            id: taskList
            anchors.fill: parent

            model: scenario
            delegate: UTaskWidget {
                z: 100000 - index
                showButtons: scenarioWidget.isEditMode
            }

            function cancelEditTasks() {
                var count = scenario.taskCount()

                for(var i = count - 1; i >= 0 ; i--) {
                    taskList.currentIndex = i

                    if (newTasks.indexOf(taskList.model.getTaskAt(i)) !== -1) {
                        scenario.deleteTaskAt(i)
                        continue
                    }

                    taskList.currentItem.cancelEditTask()
                }

                newTasks = []
            }
        }
    }

    UI.UButton {
        id: addTaskButton

        anchors.bottom: parent.bottom

        text: "Add task"
        visible: isEditMode

        onClicked: {
            var newTask = scenario.createTask()

            scenario.addTask(newTask)
            taskList.newTasks.push(newTask)
        }
    }
}
