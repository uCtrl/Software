import QtQuick 2.0

import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container
    width: 300
    height: width * 1.5

    anchors.centerIn: parent

    radius: 5
    color: _colors.uGreen

    property string iconId
    property string text

    signal clicked

    state: "NORMAL"
    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: container; color: _colors.uGreen }
        },
        State {
            name: "HOVERED"
            PropertyChanges { target: container; color: _colors.uMediumLightGreen }
        }
    ]

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        cursorShape: (container.state !== "DISABLED" ? (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor) : Qt.ArrowCursor)

        onEntered: {
            container.state = "HOVERED"
        }
        onExited: {
            container.state = "NORMAL"
        }
        onClicked: {
            container.clicked()
        }
    }

    Rectangle {
        id: imageContainer
        width: parent.width
        height: parent.width
        color: _colors.uTransparent

        UI.UFontAwesome {
            iconId: container.iconId
            anchors.centerIn: parent
            iconSize: 120
            iconColor: _colors.uWhite
        }
    }

    Rectangle {
        id: textContainer
        width: parent.width * 0.75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: imageContainer.bottom
        anchors.bottom: parent.bottom
        color: _colors.uTransparent

        ULabel.Default {
            id: textLabel
            text: container.text
            anchors.centerIn: parent
            width: parent.width
            wrapMode: Text.WordWrap
            horizontalAlignment: Text.AlignHCenter

            font.bold: true
            font.pointSize: 24
            color: _colors.uWhite
        }
    }
}
