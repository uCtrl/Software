import QtQuick 2.0
import "../UI" as UI
import QtQuick.Controls 1.0

Rectangle {
    id: container

    property string icon: "flag"
    property bool showSeparator: true
    property string label: "UNKNOWN"
    property string path: "."
    property string title: ""
    property var model: null
    property string name: ""
    state: "NORMAL"

    width: 100; height: 100

    color: _colors.uRed

    UI.UFontAwesome {
        id: icon

        anchors.centerIn: parent
        anchors.margins: 5

        iconId: container.icon
        iconSize: 40
    }

    UI.UToolTip {
        id: tooltip
        visible: false
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.right
        text: container.label
        width: 150
    }

    UI.USeparator {
        id: separator
        anchors.bottom: parent.bottom
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        cursorShape: (container.state !== "DISABLED" ? (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor) : Qt.ArrowCursor)
        onEntered: {
            tooltip.startAnimation()
            if(container.state === "NORMAL")
                container.state = "HOVER"
        }
        onExited: {
            tooltip.stopAnimation()
            if(container.state === "HOVER")
                container.state = "NORMAL"
        }

        onClicked: {
            main.resetBreadcrumb()
            main.highlightNavbar(name)
            main.swap(path, title, model)
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: icon; iconColor: _colors.uGrey }
            PropertyChanges { target: container; color: _colors.uDarkGrey }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: icon; iconColor: _colors.uDarkGrey }
            PropertyChanges { target: container; color: _colors.uLightGrey }
        },
        State {
            name: "HOVER"
            PropertyChanges { target: icon; iconColor: _colors.uMediumLightGrey }
            PropertyChanges { target: container; color: _colors.uMediumDarkGrey }
        },
        State {
            name: "DISABLED"
            PropertyChanges { target: icon; iconColor: _colors.uMediumDarkGrey }
            PropertyChanges { target: container; color: _colors.uDarkerGray }
        }
    ]
}
