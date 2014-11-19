import QtQuick 2.0

Default {
    id: label
    signal hyperLinkClicked()

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: (label.state !== "DISABLED" ? (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor) : Qt.ArrowCursor);
        onHoveredChanged: {
            if(label.state === "ENABLED") {
                label.font.underline = containsMouse
            }

        }
        onClicked: {
            hyperLinkClicked()
        }
    }
}
