import QtQuick 2.0

import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container
    width: 300
    height: width * 1.5

    anchors.centerIn: parent

    radius: radiusSize
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
            PropertyChanges { target: mouseArea; cursorShape: Qt.PointingHandCursor }
            PropertyChanges { target: container; color: _colors.uMediumLightGreen }
        }
    ]

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

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
        height: parent.height * 0.60
        anchors.top: parent.top
        anchors.topMargin: 25
        color: _colors.uTransparent

        UI.UFontAwesome {
            iconId: container.iconId
            anchors.centerIn: parent

            iconSize: (parent.width ? parent.width * 0.55 : 100)
            iconColor: _colors.uWhite
        }
    }

    ULabel.Default {
        id: textLabel
        text: container.text
        height: 100
        width: parent.width * 0.75
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25

        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        font.bold: true
        font.pointSize: 24
        color: _colors.uWhite
    }
}
