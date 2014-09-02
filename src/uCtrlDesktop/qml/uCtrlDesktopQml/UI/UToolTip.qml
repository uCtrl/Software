import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property string text: "UNKNOWN"
    property bool arrowRight: false

    anchors.leftMargin: 8
    width: 200
    height: 30

    color: _colors.uTransparent
    visible: true

    state: "HIDDEN"

    function drawArrow() {
        if (arrowRight) {
            triangle.anchors.right = container.right
        } else {
            triangle.anchors.left = container.left
        }
    }

    function startAnimation() {
        if (container.state == "HIDDEN" && !visibleTimer.running) visibleTimer.start()
    }

    function stopAnimation() {
        if (container.state == "VISIBLE") container.state = "HIDDEN"
        else if (visibleTimer.running) visibleTimer.stop()
    }

    UFontAwesome {
        id: triangle

        iconId: (arrowRight ? "CaretRight" : "CaretLeft")
        iconColor: _colors.uDarkGrey
        iconSize: 16

        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: tooltip

        width: parent.width - triangle.width
        height: parent.height

        color: _colors.uDarkGrey
        radius: radiusSize

        anchors.centerIn: parent

        ULabel.TooltipText {
            text: container.text
            anchors.centerIn: parent
        }
    }

    Timer {
        id: visibleTimer
        interval: 500
        onTriggered: container.state = "VISIBLE"
    }

    states: [
        State {
            name: "HIDDEN"
            PropertyChanges { target: container; opacity: 0 }
        },
        State {
            name: "VISIBLE"
            PropertyChanges { target: container; opacity: 1 }
        }
    ]

    transitions: Transition {
        PropertyAnimation { target: container; property: "opacity"; duration: 200 }
    }

    Component.onCompleted: drawArrow()
}
