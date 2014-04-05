import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {
    property int borderRadius: 5
    property int animationTime: 200
    property string status: "ON"

    id: container
    width: 70
    height: 30
    radius: height / 2
    color: _colors.uLightGreen
    state: status

    Rectangle {
        id: circle
        width: container.height - borderRadius * 2
        height: container.height - borderRadius * 2
        radius: height / 2
        anchors.right: container.right
        anchors.rightMargin: container.height / 2 - height / 2
        color: _colors.uDarkGreen
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: labelOnContainer
        width: parent.width - circle.width - borderRadius
        anchors.right: circle.left
        color: _colors.uTransparent
        height: parent.height

        ULabel.Heading4 {
            id: onLabel
            text: "ON"
            anchors.centerIn: parent
            color: _colors.uGreen
            font.bold: true
        }
    }

    Rectangle {
        id: labelOffContainer
        width: parent.width - circle.width - borderRadius
        anchors.left: circle.right
        color: _colors.uTransparent
        opacity: 0.9
        height: parent.height

        ULabel.Heading4 {
            id: offLabel
            text: "OFF"
            anchors.centerIn: parent
            color: _colors.uWhite
            opacity: 0
            font.bold: true
        }
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            if(container.state === "ON") {
                container.state = "OFF"
            }
            else {
                container.state = "ON"
            }
        }
    }

    states: [
        State {
            name: "ON"
            PropertyChanges { target: circle; color: _colors.uDarkGreen }
            PropertyChanges { target: container; color: _colors.uLightGreen }
            PropertyChanges { target: onLabel; opacity: 1 }
            PropertyChanges { target: offLabel; opacity: 0 }
            PropertyChanges {
                target: circle
                anchors.rightMargin: container.height / 2 - circle.height / 2
            }
        },
        State {
            name: "OFF"
            PropertyChanges { target: circle; color: _colors.uMediumDarkGrey }
            PropertyChanges { target: container; color: _colors.uMediumLightGrey }
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
            PropertyAnimation { target: onLabel; property: "opacity"; duration: animationTime / 2 }
            PropertyAnimation { target: circle; property: "anchors.rightMargin"; duration: animationTime; easing { type: Easing.InOutQuad } }
        },
        Transition {
            from: "OFF"
            to: "ON"
            ColorAnimation { target: circle; duration: animationTime }
            ColorAnimation { target: container; duration: animationTime }
            PropertyAnimation { target: offLabel; property: "opacity"; duration: animationTime / 2 }
            PropertyAnimation { target: onLabel; property: "opacity"; duration: animationTime }
            PropertyAnimation { target: circle; property: "anchors.rightMargin"; duration: animationTime; easing { type: Easing.InOutQuad } }
        }

    ]
}
