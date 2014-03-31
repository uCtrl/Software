import QtQuick 2.0

Rectangle {
    id: button

    property string text: "UNKNOWN"
    property int iconSize: 16
    property variant iconColor: _colors.uWhite

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
        z: 100
        onClicked: {
            if (state != "DISABLED") parent.execute()
        }
    }

    UFontAwesome {
        iconId: text
        iconSize: parent.iconSize
        iconColor: parent.iconColor
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
