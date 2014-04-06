import QtQuick 2.0

Rectangle {
    id: container

    property var itemData: null
    property string value: itemData ? itemData.value : "UNKNOWN"
    property string iconId: itemData ? itemData.iconId : "UNKNOWN"
    property string displayedValue: itemData ? itemData.displayedValue : "UNKNOWN"
    property int animationTime: 200

    width: parent.width
    height: 40
    radius: 5
    state: "NORMAL"

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: container; color: _colors.uTransparent }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: container; color: _colors.uGreen }
        },
        State {
            name: "HOVERED"
            PropertyChanges { target: container; color: _colors.uGrey }
        }
    ]

    transitions: [
        Transition {
            from: "NORMAL"
            to: "HOVERED"
            ColorAnimation { target: container; duration: animationTime; easing.type: Easing.Linear }
        },
        Transition {
            from: "NORMAL"
            to: "SELECTED"
            ColorAnimation { target: container; duration: animationTime; easing.type: Easing.Linear }
        },
        Transition {
            from: "HOVERED"
            to: "NORMAL"
            ColorAnimation { target: container; duration: animationTime; easing.type: Easing.Linear }
        },
        Transition {
            from: "HOVERED"
            to: "SELECTED"
            ColorAnimation { target: container; duration: animationTime; easing.type: Easing.Linear }
        },
        Transition {
            from: "SELECTED"
            to: "HOVERED"
            ColorAnimation { target: container; duration: animationTime; easing.type: Easing.Linear }
        },
        Transition {
            from: "SELECTED"
            to: "NORMAL"
            ColorAnimation { target: container; duration: animationTime; easing.type: Easing.Linear }
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
            if (container.state === "SELECTED")
                return

            container.state = "HOVERED"
        }
        onExited: {
            if (container.state === "SELECTED")
                return

            container.state = "NORMAL"
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
