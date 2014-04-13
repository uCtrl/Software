import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: scenarioWidget
    property string name: "UNKNOWN"
    property var scenarioModel
    clip:true
    property bool isEditMode: false

    color: _colors.uWhite
    height: parent.height
    width: parent.width

    function saveTasks() {
        taskList.saveTasks()
    }

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
        scenarioModel = newScenario
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

            model: scenarioModel
            delegate: UTaskWidget {
                z: 100000 - index
                showButtons: scenarioWidget.isEditMode
                taskModel: scenarioModel.getTaskAt(index)

                Component.onCompleted: {
                    taskModel.scenario = scenarioModel
                }
            }

            function saveTasks() {
                newTasks = []
                cancelEditTasks()
            }

            function cancelEditTasks() {
                var count = scenarioModel.taskCount()

                for(var i = count - 1; i >= 0 ; i--) {
                    taskList.currentIndex = i

                    if (newTasks.indexOf(model.getTaskAt(i)) !== -1) {
                        scenarioModel.deleteTaskAt(i)
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
            var newTask = scenarioModel.createTask()

            scenarioModel.addTask(newTask)
            taskList.newTasks.push(newTask)
        }
    }
}
