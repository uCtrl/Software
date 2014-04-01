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
                value: "Item #1"
                iconId: "Flag"
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
        height: item1.height + item2.height + item3.height
        width: parent.width
        anchors.top: parent.bottom
        color: _colors.uMediumGrey
        border.color: _colors.uMediumDarkGrey
        border.width: 1
        visible: false

        UComboBoxItemContainer {
            id: item1
            height: combo.height - 4
            anchors.top: parent.top
            iconId: "Flag"
            value: "Item #1"
        }
        UComboBoxItemContainer {
            id: item2
            height: combo.height - 4
            anchors.top: item1.bottom
            iconId: "Comments"
            value: "Item #2"
        }
        UComboBoxItemContainer {
            id: item3
            height: combo.height - 4
            anchors.top: item2.bottom
            iconId: "Bolt"
            value: "Item #3"
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: dropDown.visible = !dropDown.visible
    }
}
