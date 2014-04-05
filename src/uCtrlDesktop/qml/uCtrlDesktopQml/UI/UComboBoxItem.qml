import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {

    property var itemData: null

    id: item
    width: parent.width
    height: 30
    color: _colors.uTransparent

    function refresh(newItemData) {

        itemData = newItemData

        comboBoxItemIcon.refresh(itemData.iconId)
        comboBoxItemText.text = itemData.displayedValue
    }


    Rectangle {
        id: iconContainer
        width: itemData.iconId === "" ? 0 : parent.height
        height: parent.height

        color: _colors.uTransparent

        UFontAwesome {
            id: comboBoxItemIcon

            iconId: item.itemData ? item.itemData.iconId : ""
            iconColor: _colors.uWhite
            iconSize:  14
            anchors.centerIn: parent
        }
    }


    Rectangle {
        id: valueContainer
        width: parent.width - iconContainer.width
        height: parent.height
        anchors.left: iconContainer.right
        anchors.right: parent.right

        color: _colors.uTransparent
        ULabel.ComboBoxItemText {
            id: comboBoxItemText

            anchors.verticalCenter: parent.verticalCenter
            text: item.itemData.displayedValue
        }
    }
}
