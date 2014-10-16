import QtQuick 2.0

Rectangle {
    id: container

    property var itemData: null
    property string value: itemData ? itemData.value : "UNKNOWN"
    property string iconId: itemData ? itemData.iconId : "UNKNOWN"
    property string displayedValue: itemData ? itemData.displayedValue : "UNKNOWN"
    property int animationTime: 100

    width: parent.width
    height: 32
    radius: 2
    state: "NORMAL"

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: container; color: "transparent" }
            PropertyChanges { target: item; textColor: "#737373" }
        },
        State {
            name: "HOVERED"
            PropertyChanges { target: container; color: "#AAAAAA" }
            PropertyChanges { target: item; textColor: "#EDEDED" }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: container; color: "#0D9B0D" }
            PropertyChanges { target: item; textColor: "white" }
        },
        State {
            name: "HOVERED SELECTED"
            PropertyChanges { target: container; color: "#0D740D" }
            PropertyChanges { target: item; textColor: "white" }
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
