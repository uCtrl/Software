import QtQuick 2.0
import "../UI" as UI
import QtQuick.Controls 1.0

Rectangle {
    id: container

    property string icon: "flag"
    property color iconColor: _colors.uGrey
    property bool showSeparator: true
    property string label: "UNKNOWN"
    property string path: "."
    property string title: ""
    property var model: null
    property string name: ""

    width: 60; height: 58

    color: _colors.uDarkGrey

    UI.UFontAwesome {
        id: icon

        anchors.centerIn: parent
        anchors.margins: 5

        iconId: container.icon
        iconSize: 33
        iconColor: _colors.uGrey
    }

    UI.UToolTip {
        id: tooltip
        state: "HIDDEN"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.right
        text: container.label
        width: 125
    }

    UI.USeparator {
        id: separator
        anchors.bottom: parent.bottom
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: {
            tooltip.startAnimation()
            if(container.state == "")
                container.state = "HOVER"
        }
        onExited: {
            tooltip.stopAnimation()
            if(container.state == "HOVER")
                container.state = ""
        }

        onClicked: {
            if(container.state != "DISABLED") {
                main.resetBreadcrumb()
                main.highlightNavbar(name)
                main.swap(path, container.label, model)
            }
        }
    }

    states: [
        State {
            name: "ACTIVE"
            PropertyChanges { target: icon; iconColor: _colors.uWhite }
            PropertyChanges { target: container; color: _colors.uDarkGreyHover }
        },
        State {
            name: "HOVER"
            PropertyChanges { target: mouseArea; cursorShape: Qt.PointingHandCursor }
            PropertyChanges { target: icon; iconColor: _colors.uMediumLightGrey }
            PropertyChanges { target: container; color: _colors.uDarkGreyHover }
        },
        State {
            name: "DISABLED"
            PropertyChanges { target: icon; iconColor: _colors.uMediumDarkGrey }
            PropertyChanges { target: container; color: _colors.uDarkerGray }
        }
    ]

    transitions: Transition {
        ColorAnimation { duration: 75 }
    }
}
