import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {

    property var itemData: null

    id: item
    width: parent.width
    height: 30
    color: _colors.uTransparent

    function refresh(newItemData) {
        itemData.value = newItemData.value
        itemData.iconId = newItemData.iconId
        itemData.displayedValue = newItemData.displayedValue

        itemData = newItemData

        comboBoxItemIcon.iconId = itemData.iconId
        comboBoxItemText.text = itemData.displayedValue
    }

    /*
    Rectangle {
        id: iconContainer
        width: parent.height
        height: parent.height

        color: _colors.uTransparent

        UFontAwesome {
            id: comboBoxItemIcon

            iconId: item.itemData.iconId
            iconColor: _colors.uMediumDarkGrey
            iconSize:  14
            anchors.centerIn: parent
        }

    }
    */

    Rectangle {
        id: valueContainer
        width: parent.width - iconContainer.width
        height: parent.height
        anchors.right: parent.right

        color: _colors.uTransparent
        ULabel.ComboBoxItemText {
            id: comboBoxItemText

            anchors.verticalCenter: parent.verticalCenter
            text: item.itemData.displayedValue
        }
    }
}
