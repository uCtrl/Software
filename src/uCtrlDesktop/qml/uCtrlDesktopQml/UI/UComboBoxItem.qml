import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {
    id: item

    property var itemData: null
    property string textColor : _colors.uWhite

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
        width: itemData ? (itemData.iconId === "" ? 0 : parent.height) : 0
        height: parent.height

        color: _colors.uTransparent

        UFontAwesome {
            id: comboBoxItemIcon

            iconId: item.itemData ? item.itemData.iconId : ""
            iconColor: textColor
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
            text: item.itemData ? item.itemData.displayedValue : ""
            color: textColor
        }
    }
}
