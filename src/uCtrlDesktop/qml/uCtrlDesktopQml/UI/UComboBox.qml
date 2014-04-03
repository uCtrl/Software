import QtQuick 2.0
import QtQuick.Controls 1.0

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

        color: _colors.uGrey

        Rectangle {
            id: valueField
            width: combo.width - dropDownIcon.width - separator.width
            height: parent.height
            color: _colors.uTransparent

            UComboBoxItem {
                    id: valueItem

                    width: parent.width - 10
                    height: parent.height - 10
                    anchors.centerIn: parent

                    itemData: combo.itemListModel.selectedItem

                    Component.onCompleted: {
                        valueItem.refresh(combo.itemListModel.selectedItem)
                    }
            }
        }

        Rectangle {
            id: separator
            width: 1
            height: parent.height - 4
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: valueField.right
            color: _colors.uWhite
        }
    }

    Rectangle {
        id: dropDownIcon
        width: parent.height
        height: parent.height
        anchors.right: parent.right

        color: _colors.uGrey
        radius: 5

        UFontAwesome {
            iconId: "CaretDown"
            iconColor: _colors.uWhite
            iconSize: 14
            anchors.centerIn: parent
        }
    }

    Rectangle {
            id: dropDown
            z:1
            clip:true
            height: 250
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
                iconColor: _colors.uGrey
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 10
            }

            Rectangle {
                id: itemAreaContainer
                anchors.top: arrowTop.bottom
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                height: 200
                radius: 5
                color: _colors.uGrey


                Rectangle {
                    property int selectedIndex: 0

                    id: itemArea
                    width: parent.width - 10
                    height: parent.height - 10
                    anchors.centerIn: parent
                    color: _colors.uTransparent

                    ListView {
                        property var pComboBoxItemContainer: null

                        id: dropDownMenu
                        anchors.fill: parent

                        model: itemListModel
                        delegate: UComboBoxItemContainer {

                            itemData: itemListModel.getItemDataAt(index)
                            onItemSelected: {
                                dropDownMenu.deselectItem()
                                dropDownMenu.pComboBoxItemContainer = this
                                selectItem()
                                combo.selectItem(index)
                            }
                        }

                        function deselectItem() {
                            if (pComboBoxItemContainer)
                                pComboBoxItemContainer.deselectItem()
                        }
                    }

                }
            }
        }

    function selectItem(index) {
        combo.itemListModel.selectedItem = itemListModel.getItemDataAt(index)
        valueItem.refresh(combo.itemListModel.selectedItem)
        dropDown.visible = false

    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dropDown.visible = !dropDown.visible
        }


    }
}
