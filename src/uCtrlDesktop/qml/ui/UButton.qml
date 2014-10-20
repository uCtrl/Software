import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../label" as ULabel

Rectangle {
    id: button

    property string text: ""
    property string iconId: ""
    property int iconSize: 16
    property color buttonColor: "#0D9B0D"
    property color buttonHoveredColor: "#0DBE0D"
    property color buttonTextColor : "white"
    property color buttonHoveredTextColor : buttonTextColor
    property color buttonDisabledColor : "#EDEDED"
    property color buttonDisabledTextColor : "#3C3C3C"
    property color buttonErrorColor : "#A60E0E"
    property color buttonErrorHoveredColor : "#D90E0E"
    property color buttonErrorTextColor : "white"
    property bool bold: true


    height: 30
    width: 100
    radius: 4

    color: "#0D9B0D"
    state: "ENABLED"

    signal clicked
    function execute() {
        // @TODO : Change console log for alert
        if (state != "DISABLED") {
            button.clicked()
        }
    }

    function changeText(newText) {
        label.text = newText
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
        color: "transparent"
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
            font.bold: button.bold
            color: "white"
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
            PropertyChanges { target: mouseArea; cursorShape: Qt.PointingHandCursor }
            PropertyChanges { target: button; color: buttonHoveredColor }
            PropertyChanges { target: label; color: buttonHoveredTextColor }
            PropertyChanges { target: icon; iconColor: buttonHoveredTextColor }
        },
        State {
            name: "DISABLED"
            PropertyChanges { target: button; color: buttonDisabledColor }
            PropertyChanges { target: label; color: buttonDisabledTextColor }
            PropertyChanges { target: icon; iconColor: buttonDisabledTextColor }
        },
        State {
            name: "ERROR"
            PropertyChanges { target: button; color: buttonErrorColor }
            PropertyChanges { target: label; color: buttonErrorTextColor }
            PropertyChanges { target: icon; iconColor: buttonErrorTextColor }
        },
        State {
            name: "ERROR HOVERED"
            PropertyChanges { target: button; color: buttonErrorHoveredColor }
            PropertyChanges { target: label; color: buttonErrorTextColor }
            PropertyChanges { target: icon; iconColor: buttonErrorTextColor }
        }
    ]
}