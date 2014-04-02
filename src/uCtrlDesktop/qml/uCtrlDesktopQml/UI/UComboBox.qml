import QtQuick 2.0

Rectangle {

    property var itemListModel: null

    id: combo

    width: 200
    height: 40
    radius: 5

    color: _colors.uTransparent

    Rectangle {
        id: valueBackground
        width: parent.width - parent.height / 2
        height: parent.height

        color: _colors.uMediumGrey

        Rectangle {
            id: valueField
            width: combo.width - dropDownIcon.width - separator.width
            height: parent.height
            color: _colors.uTransparent

            UComboBoxItem {
                    id: value

                    width: parent.width - 10
                    height: parent.height - 10
                    anchors.centerIn: parent

                    itemData: combo.itemListModel.selectedItem
            }
        }

        Rectangle {
            id: separator
            width: 1
            height: parent.height - 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: valueField.right
            color: _colors.uMediumDarkGrey
        }
    }

    Rectangle {
        id: dropDownIcon
        width: parent.height
        height: parent.height
        anchors.right: parent.right

        color: _colors.uMediumGrey
        radius: 5

        UFontAwesome {
            iconId: "CaretDown"
            iconColor: _colors.uMediumDarkGrey
            iconSize: 14
            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: dropDown
        z:100
        height: 150
        width: parent.width
        anchors.top: parent.bottom
        anchors.topMargin: 10
        color: _colors.uTransparent
        visible: false

        UFontAwesome {
            id: arrowTop
            height: 10
            iconId: "CaretUp"
            iconSize: 16
            iconColor: _colors.uMediumGrey
            anchors.right: parent.right
            anchors.rightMargin: combo.height / 2
        }
        Rectangle {
            id: itemAreaContainer
            anchors.top: arrowTop.bottom
            width: parent.width
            height: 200
            radius: 5
            color: _colors.uMediumGrey

            Rectangle {
                id: itemArea
                width: parent.width - 10
                height: parent.height - 10
                anchors.centerIn: parent
                color: _colors.uTransparent

                ListView {
                    id: dropDownMenu
                    anchors.fill: parent

                    model: itemListModel
                    delegate: UComboBoxItemContainer {

                        itemData: itemListModel.getItemDataAt(index)

                        onItemSelected: {
                            selectItem(index)
                        }
                    }
                }
            }
        }

    }
    function selectItem(index) {
        combo.itemListModel.selectedItem = itemListModel.getItemDataAt(index)
        value.refresh(combo.itemListModel.selectedItem)
        dropDown.visible = false

        console.log(index)
        console.log(combo.itemListModel.selectedItem.value)
        console.log(combo.itemListModel.selectedItem.displayedValue)
        console.log(combo.itemListModel.selectedItem.iconId)
        console.log(value.itemData.value)
        console.log(value.itemData.displayedValue)
        console.log(value.itemData.iconId)
    }

    MouseArea {
        anchors.fill: parent
        onClicked: dropDown.visible = !dropDown.visible
    }
}
