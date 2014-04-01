import QtQuick 2.0

Rectangle {
    property string value: "UNKNOWN"
    property string iconId: "UNKNOWN"

    id: container
    width: parent.width
    height: 40
    color: _colors.uTransparent

    UComboBoxItem {
        id: item
        width: parent.width - 6
        height: parent.height - 6
        anchors.centerIn: parent
        value: parent.value
        iconId: parent.iconId
    }

    USeparator {
        anchors.bottom: parent.bottom
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: {
            if(containsMouse)
                container.color = _colors.uRoyalBlue
            else
                container.color = _colors.uTransparent
        }
    }
}
