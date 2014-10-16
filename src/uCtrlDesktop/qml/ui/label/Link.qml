import QtQuick 2.0

Default {
    id: label

    property var redirectPath
    property string state: "ENABLED"
    property var redirectModel

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
            if(label.state === "ENABLED") {
                main.swap(redirectPath, label.text, redirectModel)
            }
        }
    }
}
