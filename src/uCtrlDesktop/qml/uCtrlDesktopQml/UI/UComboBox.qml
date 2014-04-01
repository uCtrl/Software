import QtQuick 2.0

Rectangle {

    id: combo
    width: 250
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
                value: "1"
                iconId: "Flag"
                displayedValue: "Item #1"
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
        height: 150
        width: parent.width
        anchors.top: parent.bottom
        anchors.topMargin: 10
        color: _colors.uTransparent
        visible: true

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
            height: item1.height + item2.height + item3.height + 10
            radius: 5
            color: _colors.uMediumGrey

            Rectangle {
                id: itemArea
                width: parent.width - 10
                height: parent.height - 10
                anchors.centerIn: parent
                color: _colors.uTransparent

                UComboBoxItemContainer {
                    id: item1
                    value: "1"
                    displayedValue: "Item #1"
                    iconId: "Flag"
                }
                UComboBoxItemContainer {
                    id: item2
                    value: "2"
                    displayedValue: "Item #2"
                    iconId: "Bolt"
                    anchors.top: item1.bottom
                }
                UComboBoxItemContainer {
                    id: item3
                    value: "3"
                    displayedValue: "Item #3"
                    iconId: "Time"
                    anchors.top: item2.bottom
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: dropDown.visible = !dropDown.visible
    }
}
