import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../UI/ULabel" as ULabel

Rectangle {
    id: button

    property string text: ""
    property string iconId: ""
    property int iconSize: 16
    property color buttonColor: _colors.uGreen
    property color buttonHoveredColor: _colors.uMediumLightGreen
    property color buttonTextColor : _colors.uWhite

    height: 30
    width: 100
    radius: 5

    color: _colors.uGreen
    state: "ENABLED"

    signal clicked
    function execute() {
        // @TODO : Change console log for alert
        if (state != "DISABLED") {
            button.clicked()
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        z: 100
        hoverEnabled: true
        onEntered: {
            if(button.state === "ENABLED")
                button.state = "HOVERED"
            else if(button.state === "ERROR")
                button.state = "ERROR HOVERED"
        }
        onExited: {
            if(button.state === "HOVERED")
                button.state = "ENABLED"
            else if(button.state === "ERROR HOVERED")
                button.state = "ERROR"
        }
        onClicked: {
            if (button.state != "DISABLED") parent.execute()
        }
    }

    Rectangle {
        id: content
        width: icon.width + label.width
        height: parent.height
        color: _colors.uTransparent
        anchors.centerIn: parent

        UFontAwesome {
            id: icon
            iconId: button.iconId
            iconSize: button.iconSize
            width: (iconId === "" ? 0 : 25)
            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
        }

        ULabel.Default {
            id: label
            font.bold: true
            color: _colors.uWhite
            text: button.text
            anchors.left: icon.right
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    states: [
        State {
            name: "ENABLED"
            PropertyChanges { target: button; color: buttonColor }
            PropertyChanges { target: label; color: buttonTextColor }
            PropertyChanges { target: icon; iconColor: buttonTextColor }
        },
        State {
            name: "HOVERED"
            PropertyChanges { target: button; color: buttonHoveredColor }
            PropertyChanges { target: label; color: buttonTextColor }
            PropertyChanges { target: icon; iconColor: buttonTextColor }
        },
        State {
            name: "DISABLED"
            PropertyChanges { target: button; color: _colors.uLightGrey }
            PropertyChanges { target: label; color: _colors.uDarkGrey }
            PropertyChanges { target: icon; iconColor: _colors.uDarkGrey }
        },
        State {
            name: "ERROR"
            PropertyChanges { target: button; color: _colors.uDarkRed }
            PropertyChanges { target: label; color: _colors.uWhite }
            PropertyChanges { target: icon; iconColor: _colors.uWhite }
        },
        State {
            name: "ERROR HOVERED"
            PropertyChanges { target: button; color: _colors.uRed }
            PropertyChanges { target: label; color: _colors.uWhite }
            PropertyChanges { target: icon; iconColor: _colors.uWhite }
        }
    ]
}
