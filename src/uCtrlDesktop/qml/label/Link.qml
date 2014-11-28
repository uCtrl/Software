import QtQuick 2.0

Default {
    id: label
    signal hyperLinkClicked()

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor)
        onHoveredChanged: {
            label.font.underline = containsMouse
        }
        onClicked: {
            hyperLinkClicked()
        }
    }
}
