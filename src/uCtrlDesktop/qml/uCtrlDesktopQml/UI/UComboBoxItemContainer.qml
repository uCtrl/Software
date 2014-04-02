import QtQuick 2.0

Rectangle {
    property var itemData: null
    property string value: itemData ? itemData.value : "UNKNOWN"
    property string iconId: itemData ? itemData.iconId : "UNKNOWN"
    property string displayedValue: itemData ? itemData.displayedValue : "UNKNOWN"

    signal itemSelected

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

        itemData: container.itemData
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
        onClicked: itemSelected()
    }
}
