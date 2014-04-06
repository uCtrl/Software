import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property string text: "UNKNOWN"
    property bool arrowRight: false

    anchors.leftMargin: 8
    width: 200
    height: 40

    color: _colors.uTransparent

    visible: false

    function drawArrow() {
        if (arrowRight) {
            triangle.anchors.right = container.right
        } else {
            triangle.anchors.left = container.left
        }
    }

    function startAnimation() {
        if (!visible && !visibleTimer.running) visibleTimer.start()
    }

    function stopAnimation() {
        if (visible) visible = false
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
        radius: 5

        anchors.centerIn: parent

        ULabel.TooltipText {
            text: container.text
            anchors.centerIn: parent
        }
    }

    Timer {
        id: visibleTimer
        interval: 1000
        onTriggered: parent.visible = true
    }

    Component.onCompleted: drawArrow()
}
