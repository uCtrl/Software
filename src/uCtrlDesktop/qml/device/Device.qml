import QtQuick 2.0

Rectangle {

    id: container

    color: "transparent"

    Rectangle {
        id: square

        color: "white"

        anchors.fill: parent
        anchors.margins: 20
    }

    Rectangle {
        id: separator

        anchors.horizontalCenter: parent.horizontalCenter

        anchors.top: square.top
        anchors.bottom: square.bottom

        anchors.margins: 20

        width: 1

        color: "#EDEDED"
    }
}
