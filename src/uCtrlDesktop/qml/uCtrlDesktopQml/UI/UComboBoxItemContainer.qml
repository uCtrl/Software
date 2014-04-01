import QtQuick 2.0

Rectangle {
    property string value: "UNKNOWN"
    property string iconId: "UNKNOWN"
    property string displayedValue: "UNKNOWN"

    id: container
    width: parent.width
    height: 40
    color: _colors.uTransparent
    radius: 5

    UComboBoxItem {
        id: item
        width: parent.width - 6
        height: parent.height - 6
        anchors.centerIn: parent
        value: parent.value
        displayedValue: parent.displayedValue
        iconId: parent.iconId
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: {
            if(containsMouse)
                container.color = _colors.uLightGrey
            else
                container.color = _colors.uTransparent
        }
        onClicked: {
            container.parent.parent.parent.visible = false
        }
    }
}
