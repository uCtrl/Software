import QtQuick 2.0

import "../label" as ULabel

Rectangle {
    property int borderRadius: 5
    property int animationTime: 200

    state: "ON"

    id: container
    width: 65
    height: 27
    radius: height / 2
    color: "#DAF2DA"

    clip: true

    Rectangle {
        id: circle
        width: container.height - borderRadius * 2
        height: container.height - borderRadius * 2
        radius: height / 2
        anchors.right: container.right
        anchors.rightMargin: container.height / 2 - height / 2
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: labelOnContainer
        width: parent.width - circle.width - borderRadius
        anchors.right: circle.left
        color: "transparent"
        height: parent.height

        ULabel.Heading4 {
            id: onLabel
            text: "ON"
            anchors.centerIn: parent
            color: "#0D9B0D"
            font.bold: true
            font.pointSize: 12
        }
    }

    Rectangle {
        id: labelOffContainer
        width: parent.width - circle.width - borderRadius
        anchors.left: circle.right
        color: "transparent"
        opacity: 0.9
        height: parent.height

        ULabel.Heading4 {
            id: offLabel
            text: "OFF"
            anchors.centerIn: parent
            color: "white"
            opacity: 0
            font.bold: true
            font.pointSize: 12
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        onClicked: {
            if(container.state === "ON") {
                container.state = "OFF"
            }
            else {
                container.state = "ON"
            }

            stateChanged(container.state)
        }
    }

    states: [
        State {
            name: "ON"
            PropertyChanges { target: circle; color: "#0D9B0D" }
            PropertyChanges { target: container; color: "#DAF2DA" }
            PropertyChanges { target: onLabel; opacity: 1 }
            PropertyChanges { target: offLabel; opacity: 0 }
            PropertyChanges {
                target: circle
                anchors.rightMargin: container.height / 2 - circle.height / 2
            }
        },
        State {
            name: "OFF"
            PropertyChanges { target: circle; color: "#737373" }
            PropertyChanges { target: container; color: "#D4D4D4" }
            PropertyChanges { target: onLabel; opacity: 0 }
            PropertyChanges { target: offLabel; opacity: 1 }
            PropertyChanges {
                target: circle
                anchors.rightMargin: container.width - circle.width - borderRadius
            }
        }
    ]

    transitions: [
        Transition {
            from: "ON"
            to: "OFF"
            ColorAnimation { target: circle; duration: animationTime }
            ColorAnimation { target: container; duration: animationTime }
            PropertyAnimation { target: offLabel; property: "opacity"; duration: animationTime }
            PropertyAnimation { target: onLabel; property: "opacity"; duration: animationTime }
            PropertyAnimation { target: circle; property: "anchors.rightMargin"; duration: animationTime; easing { type: Easing.InOutQuad } }
        },
        Transition {
            from: "OFF"
            to: "ON"
            ColorAnimation { target: circle; duration: animationTime }
            ColorAnimation { target: container; duration: animationTime }
            PropertyAnimation { target: offLabel; property: "opacity"; duration: animationTime }
            PropertyAnimation { target: onLabel; property: "opacity"; duration: animationTime }
            PropertyAnimation { target: circle; property: "anchors.rightMargin"; duration: animationTime; easing { type: Easing.InOutQuad } }
        }

    ]
}
