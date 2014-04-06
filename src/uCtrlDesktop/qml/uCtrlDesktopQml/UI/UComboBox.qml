import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {

    property var itemListModel: [
                                    { value:"0", displayedValue:"Sleep", iconId:"Ok"},
                                    { value:"1", displayedValue:"Hibernate", iconId:"Search"},
                                    { value:"2", displayedValue:"Shut Down", iconId:"ChevronLeft"},
                                    { value:"3", displayedValue:"Restart", iconId:"Trash"},
                                    { value:"4", displayedValue:"Start", iconId:"Bolt"}
                                ]
    property var selectedItem: itemListModel[0]
    z:1000

    signal selectValue(var selectedItem)

    id: combo

    width: 200
    height: 40
    radius: 5

    color: _colors.uTransparent

    Rectangle {
        id: valueBackground
        width: parent.width - parent.height / 2
        height: parent.height

        color: _colors.uMediumLightGrey

        radius: 5

        Rectangle {
            id: valueField
            width: combo.width - dropDownIcon.width
            height: parent.height
            color: _colors.uTransparent

            UComboBoxItem {
                id: valueItem

                width: parent.width - 10
                height: parent.height - 10
                anchors.centerIn: parent

                itemData: itemListModel[0]

                Component.onCompleted: {
                    valueItem.refresh(itemListModel[0])
                }
            }
        }
    }

    Rectangle {
        id: dropDownIcon
        width: parent.height
        height: parent.height
        anchors.right: parent.right

        color: _colors.uMediumLightGrey
        radius: 5

        UFontAwesome {
            id: arrowDown

            iconId: "CaretDown"
            iconColor: _colors.uDarkGrey
            iconSize: 14
            anchors.centerIn: parent
        }
    }

    Rectangle {
            id: dropDown

            clip:true

            height: (itemListModel.length <=5 ? itemListModel.length*45 : 225)
            width: valueBackground.width + dropDownIcon.width

            anchors.top: parent.bottom
            anchors.horizontalCenter: parent.horizontalCenter

            color: _colors.uTransparent
            visible: false

            UFontAwesome {
                id: arrowTop

                height: 10
                iconId: "CaretUp"
                iconSize: 16
                iconColor: _colors.uMediumLightGrey

                anchors.top: parent.top

                anchors.right: parent.right
                anchors.rightMargin: 22
            }

            Rectangle {
                id: itemAreaContainer
                anchors.top: arrowTop.top
                anchors.topMargin: 7

                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                height: dropDown.height * 0.95
                radius: 5
                color: _colors.uMediumLightGrey


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

    MouseArea {
        anchors.fill: parent
        onClicked: {
            dropDown.visible = !dropDown.visible
        }
    }
}
