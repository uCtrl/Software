import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: combo
    property var itemListModel: [
                                    { value:"0", displayedValue:"Sleep", iconId:"Ok"},
                                    { value:"1", displayedValue:"Hibernate", iconId:"Search"},
                                    { value:"2", displayedValue:"Shut Down", iconId:"ChevronLeft"},
                                    { value:"3", displayedValue:"Restart", iconId:"Trash"},
                                    { value:"4", displayedValue:"Start", iconId:"Bolt"}
                                ]

    property var selectedItem
    z:1000
    signal selectValue(var newValue)
    property int itemDisplayedBeforeScroll: 10

    width: 200
    height: 40

    color: "transparent"

    Rectangle {
        id: valueBackground
        width: parent.width - parent.height / 2
        height: parent.height

        color: "#D4D4D4"
        radius: 2

        Rectangle {
            id: valueField
            width: combo.width - dropDownIcon.width
            height: parent.height
            color: "transparent"

            UComboboxItem {
                    id: valueItem

                    width: parent.width - 10
                    height: parent.height - 10
                    anchors.centerIn: parent

                    itemData: selectedItem
                    textColor: "#737373"
            }
        }
    }

    Rectangle {
        id: dropDownIcon
        width: parent.height
        height: parent.height
        anchors.right: parent.right

        color: "#D4D4D4"
        radius: 2

        UFontAwesome {
            id: arrowDown

            iconId: "CaretDown"
            iconColor: "#737373"
            iconSize: 14
            anchors.centerIn: parent
        }
    }

    Rectangle {
            id: dropDown
            clip:true
            height: 20 + (itemListModel.length <= itemDisplayedBeforeScroll ? itemListModel.length * 32 : itemDisplayedBeforeScroll * 32)
            width: combo.width
            anchors.top: parent.bottom
            anchors.topMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            visible: false

            UFontAwesome {
                id: arrowTop
                height: 10
                iconId: "CaretUp"
                iconSize: 16
                iconColor: "#D4D4D4"

                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: dropDownIcon.width / 2
            }

            Rectangle {
                id: itemAreaContainer
                anchors.top: arrowTop.bottom
                anchors.topMargin: -2 // Put rectangle on bottom of the caret
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                height: dropDown.height - 10
                radius: 2
                color: "#D4D4D4"

                Rectangle {
                    property int selectedIndex: 0

                    id: itemArea
                    width: parent.width - 10
                    height: parent.height - 10
                    anchors.centerIn: parent
                    color: "transparent"

                    ListView {
                        property var pComboBoxItemContainer: null

                        id: dropDownMenu
                        anchors.fill: parent
                        interactive: itemListModel.length > itemDisplayedBeforeScroll

                        model: itemListModel
                        delegate: UComboboxItemContainer {

                            itemData: itemListModel[index]
                            onItemSelected: {
                                dropDownMenu.deselectItem() // Deselect the previously selected drop down menu item
                                dropDownMenu.pComboBoxItemContainer = this // Keep in memory that this one is the current now
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
        selectedItem = itemListModel[index]
        valueItem.refresh(selectedItem)
        dropDown.visible = false
        selectValue(selectedItem.value)
    }

    function setSelectedItem(newSelectedItem) {
        selectedItem = newSelectedItem
        valueItem.refresh(selectedItem)
        dropDown.visible = false
        selectValue(selectedItem.value)
    }

    function selectItemByValue(value) {
        for (var i = 0; i < itemListModel.length; i++) {
            if (itemListModel[i].value === value) {
                selectItem(i)
                break
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            dropDown.visible = !dropDown.visible
        }
    }
}
