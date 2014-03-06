import QtQuick 2.0

Rectangle {
    property string status: "UNKNOWN"

    width: parent.width
    color: "#808080"
    border.color: "black"
    border.width: 2
    height: 100

    ULabel {
        text: "Sinon:"
        anchors.top: parent.top
        anchors.left: parent.left
        color: "white"
        font.pointSize: 14
        anchors.leftMargin: 5
    }

    Rectangle {
        anchors.centerIn: parent
        width: elseLabel.width + stateContainer.width + 5
        height: 30
        color: "transparent"

        ULabel {
            id: elseLabel
            text: "Changer l'état pour"
            color: "black"
            font.pointSize: 14
            anchors.verticalCenter: parent.verticalCenter
        }

        Rectangle {
            id: stateContainer
            color: "white"

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: elseLabel.right
            anchors.leftMargin: 5

            width: stateLabel.width + 10
            height: parent.height - 10

            ULabel {
                id: stateLabel
                text: status
                anchors.centerIn: parent
                font.pointSize: 12
            }
        }
    }
}
