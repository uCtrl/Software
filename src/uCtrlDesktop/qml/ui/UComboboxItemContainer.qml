import QtQuick 2.0
import "UColors.js" as Colors

Rectangle {
    id: container

    property var itemData: null
    property string value: itemData ? itemData.value : "UNKNOWN"
    property string iconId: itemData ? itemData.iconId : "UNKNOWN"
    property string displayedValue: itemData ? itemData.displayedValue : "UNKNOWN"
    property int animationTime: 100

    property string itemTextColor: Colors.uMediumDarkGrey

    property string hoverColor: Colors.uGrey
    property string hoverTextColor: Colors.uLightGrey

    property string selectedItemColor: Colors.uGreen
    property string selectedItemTextColor: Colors.uWhite
    property string selectedItemHoverColor: Colors.uDarkGreen
    property string selectedItemHoverTextColor: Colors.uWhite

    width: parent.width
    height: 32
    radius: 2
    state: "NORMAL"

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: container; color: Colors.uTransparent }
            PropertyChanges { target: item; textColor: itemTextColor }
        },
        State {
            name: "HOVERED"
            PropertyChanges { target: container; color: hoverColor }
            PropertyChanges { target: item; textColor: hoverTextColor }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: container; color: selectedItemColor }
            PropertyChanges { target: item; textColor: selectedItemTextColor }
        },
        State {
            name: "HOVERED SELECTED"
            PropertyChanges { target: container; color: selectedItemHoverColor }
            PropertyChanges { target: item; textColor: selectedItemHoverTextColor }
        }
    ]

    signal itemSelected

    UComboboxItem {
        id: item
        width: parent.width - 6
        height: parent.height - 6
        anchors.centerIn: parent

        itemData: container.itemData
    }

    MouseArea {
        anchors.fill: item
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: {
            if (container.state === "HOVERED SELECTED" || container.state === "SELECTED") {
                container.state = "HOVERED SELECTED"
            } else {
                container.state = "HOVERED"
            }
        }
        onExited: {
            if (container.state === "HOVERED SELECTED" || container.state === "SELECTED") {
                container.state = "SELECTED"
            } else {
                container.state = "NORMAL"
            }
        }
        onClicked: {
            itemSelected()
        }
    }

    function selectItem() {
        container.state = "SELECTED"
    }

    function deselectItem() {
        container.state = "NORMAL"
    }
}
