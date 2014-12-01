import QtQuick 2.0

import "../label" as ULabel
import "UColors.js" as Colors

Rectangle {

    id: item

    property var itemData: null
    property string textColor : Colors.uWhite

    width: parent.width
    height: 30
    color: Colors.uTransparent

    function refresh(newItemData) {
        itemData = newItemData
        if(typeof(itemData) !== "undefined" && itemData !== null)
            comboBoxItemIcon.refresh(itemData.iconId)
        comboBoxItemText.text = (itemData !== null && itemData !== undefined && itemData !== 0 ? itemData.displayedValue : "")
    }

    Rectangle {
        id: iconContainer
        width: (typeof(itemData) === 'undefined' || itemData === null || typeof(itemData.iconId) === 'undefined' || itemData.iconId === "") ? 0 : 22
        height: parent.height

        color: Colors.uTransparent

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
        anchors.leftMargin: 5
        anchors.right: parent.right

        color: Colors.uTransparent
        ULabel.ComboBoxItemText {
            id: comboBoxItemText

            height: parent.height
            anchors.verticalCenter: parent.verticalCenter
            text: typeof(item.itemData) != 'undefined' && item.itemData !== null ? item.itemData.displayedValue : ''
            verticalAlignment: Text.AlignVCenter

            color: textColor
        }
    }
}
