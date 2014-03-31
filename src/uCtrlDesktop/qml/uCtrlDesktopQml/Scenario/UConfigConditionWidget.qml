import QtQuick 2.0

import "../UI" as UI

Rectangle {
    property var conditionModel: taskModel.getConditionAt(index)
    property bool isConditionOfTask: true

    width: parent.width
    height: 35

    color: _colors.uTransparent

    UI.UButton {
        id: deleteBtn

        text: "x"

        width: 20
        height: 20

        anchors.right: parent.right
        anchors.rightMargin: 10

        function execute() {
            if (isConditionOfTask) {
                var pTask = conditionModel.conditionParent
                pTask.deleteConditionAt(index)
            }
        }
    }
}
