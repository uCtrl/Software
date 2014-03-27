import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

Rectangle {
    id: button

    property string text: "UNKNOWN"
    height: 30
    width: 100

    radius: 5
    anchors.margins: 4

    color: _colors.uGreen
    state: "NORMAL"

    function execute() {
        // @TODO : Change console log for alert
        if (state != "DISABLED") console.log("Warning execute method not overriden")
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: {
            if (state != "DISABLED") parent.execute()
        }
    }

    Text {
        id: label
        font.bold: true
        color: "white"
        text: button.text
        anchors.centerIn: parent
    }

    states: [
        State {
            name: "ENABLED"
            PropertyChanges { target: button; color: _colors.uGreen }
            PropertyChanges { target: label; color: _colors.uWhite }
        },
        State {
            name: "DISABLED"
            PropertyChanges { target: button; color: _colors.uLightGrey }
            PropertyChanges { target: label; color: _colors.uDarkGrey }
        },
        State {
            name: "ERROR"
            PropertyChanges { target: button; color: _colors.uDarkRed }
            PropertyChanges { target: label; color: _colors.uWhite }
        }
    ]

    transitions: [
        Transition {
            ColorAnimation { from: _colors.uGreen; to: _colors.uLightGrey; duration: 75 }
        }
    ]
}
