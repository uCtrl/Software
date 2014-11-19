import QtQuick 2.0

Default {
    id: label

    property var redirectPath
    property string state: "ENABLED"
    property var redirectModel

    signal linkClicked();

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: (label.state !== "DISABLED" ? (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor) : Qt.ArrowCursor);
        onClicked: {
            linkClicked()
        }

        onHoveredChanged: {
            if(label.state === "ENABLED") {
                label.font.underline = containsMouse
            }
        }
    }
}
