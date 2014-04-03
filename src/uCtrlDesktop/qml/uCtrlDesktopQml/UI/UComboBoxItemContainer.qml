import QtQuick 2.0

Rectangle {
    property var itemData: null
    property string value: itemData ? itemData.value : "UNKNOWN"
    property string iconId: itemData ? itemData.iconId : "UNKNOWN"
    property string displayedValue: itemData ? itemData.displayedValue : "UNKNOWN"

    property bool isSelected: false

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
        anchors.fill: item
        hoverEnabled: true
        onHoveredChanged: {
            if (isSelected)
                return

            if(containsMouse)
                container.color = _colors.uGreen
            else
                container.color = _colors.uTransparent
        }
        onClicked: {
            if (mouse.y < item.y + 5)
                return

            if (mouse.y > (item.y + item.height))
                return

            itemSelected()
        }
    }

    function selectItem() {
        isSelected = true

        container.color = _colors.uWhite
    }

    function deselectItem() {
        isSelected = false

        container.color = _colors.uTransparent
    }
}
