import QtQuick 2.0

Rectangle {
    id: container

    Rectangle {
        id: currentValueContainer

        anchors.top: parent.top
        anchors.left: parent.left

        height: 125; width: 250

        color: "cyan"
    }

    Rectangle {
        id: periodContainer

        anchors.top: parent.top
        anchors.left: currentValueContainer.right

        height: currentValueContainer.height; width: parent.width - currentValueContainer.width

        color: "blue"
    }
}
