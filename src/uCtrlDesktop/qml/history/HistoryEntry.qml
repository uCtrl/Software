import QtQuick 2.0

Rectangle {
    id: historyEntry
    width: parent.width
    height: 50

    property variant model: null

    Rectangle
    {
        id: displayArea

        width: parent.width
        height: parent.height - 10
        anchors.centerIn: parent

        Rectangle
        {
            id: entryHeader
            width: parent.width * 0.25
            height: parent.height

            radius: 5
            color: "green"
        }

        Rectangle
        {
            id: entryDescription

            anchors.left: entryHeader.right
            anchors.right: entryTimestamp.left
        }

        Rectangle
        {
            id: entryTimestamp

            anchors.right: parent.height
        }
    }
}
