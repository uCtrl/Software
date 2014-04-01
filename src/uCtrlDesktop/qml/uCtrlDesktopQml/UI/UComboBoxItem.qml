import QtQuick 2.0

import "../UI/ULabel" as ULabel

Rectangle {
    property string value: "UNKNOWN"
    property string iconId: "UNKNOWN"
    id: item
    width: parent.width
    height: 30
    color: _colors.uTransparent

    Rectangle {
        id: iconContainer
        width: parent.height
        height: parent.height

        color: _colors.uTransparent

        UFontAwesome {
            iconId: item.iconId
            iconColor: _colors.uMediumDarkGrey
            iconSize: 14
            anchors.centerIn: parent
        }
    }
    Rectangle {
        id: valueContainer
        width: parent.width - iconContainer.width
        height: parent.height
        anchors.right: parent.right

        color: _colors.uTransparent
        ULabel.ComboBoxItemText {
            anchors.verticalCenter: parent.verticalCenter
            text: item.value
        }
    }
}
