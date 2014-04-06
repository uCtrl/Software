import QtQuick 2.0
import "../UI" as UI
import QtQuick.Controls 1.0

Rectangle {
    id: container

    property string icon: "Ok"
    property bool showSeparator: true
    property string label: "UNKNOWN"
    property string path: "."
    property var model: null

    width: 100; height: 100

    color: _colors.uTransparent

    Rectangle {
        id: highlight

        anchors.fill: parent
        anchors.margins: 10

        color: _colors.uGrey
        opacity: 0.1

        visible: mouseArea.containsMouse
    }

    UI.UFontAwesome {
        id: icon

        anchors.centerIn: parent
        anchors.margins: 5

        iconId: container.icon
        iconSize: 50
        iconColor: _colors.uGrey
    }

    UI.UToolTip {
        id: tooltip
        visible: false
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


        onEntered: tooltip.startAnimation()
        onExited: tooltip.stopAnimation()

        onClicked: {
            main.resetBreadcrumb()
            main.swap(path, container.label, model)
        }
    }
}
