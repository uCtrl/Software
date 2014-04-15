import QtQuick 2.0

Rectangle {
    id: container

    property var itemData: null
    property string value: itemData ? itemData.value : "UNKNOWN"
    property string iconId: itemData ? itemData.iconId : "UNKNOWN"
    property string displayedValue: itemData ? itemData.displayedValue : "UNKNOWN"
    property int animationTime: 100

    width: parent.width
    height: 40
    radius: 5
    state: "NORMAL"

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: container; color: _colors.uTransparent }
            PropertyChanges { target: item; textColor: _colors.uDarkGrey }
        },
        State {
            name: "HOVERED"
            PropertyChanges { target: container; color: _colors.uGrey }
            PropertyChanges { target: item; textColor: _colors.uLightGrey }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: container; color: _colors.uGreen }
            PropertyChanges { target: item; textColor: _colors.uWhite }
        },
        State {
            name: "HOVERED SELECTED"
            PropertyChanges { target: container; color: _colors.uDarkGreen }
            PropertyChanges { target: item; textColor: _colors.uWhite }
        }
    ]

    signal itemSelected

    UComboBoxItem {
        id: item
        width: parent.width - 6
        height: parent.height - 6
        anchors.centerIn: parent

        itemData: container.itemData
    }

    MouseArea {
        anchors.fill: item
        hoverEnabled: true
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
            console.log("Combo clicked")
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
