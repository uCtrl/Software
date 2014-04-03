import QtQuick 2.0

Rectangle {
    id: tab

    property bool isFirst: true
    property bool isLast: false
    property string iconId
    property int iconSize
    property int animationTime: 200
    state: "NORMAL"

    signal clicked()

    width: parent.height
    height: parent.height
    color: _colors.uTransparent

    Rectangle {
        id: mainRectangle
        anchors.fill: parent
        radius: 5
    }

    Rectangle {
        id: subRectangle
        width: parent.width / 2
        height: parent.height
    }

    Component.onCompleted: {
        if(isFirst && isLast) {
            subRectangle.width = 0
        } else if(isFirst) {
            subRectangle.anchors.right = subRectangle.parent.right
        } else if(isLast) {
            subRectangle.anchors.left = subRectangle.parent.left
        } else {
            mainRectangle.radius = 0
            subRectangle.width = 0
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: mainRectangle; color: _colors.uGrey }
            PropertyChanges { target: subRectangle; color: _colors.uGrey }
        },
        State {
            name: "SELECTED"
            PropertyChanges { target: mainRectangle; color: _colors.uGreen }
            PropertyChanges { target: subRectangle; color: _colors.uGreen }
        },
        State {
            name: "HOVERED"
            PropertyChanges { target: mainRectangle; color: _colors.uDarkGrey }
            PropertyChanges { target: subRectangle; color: _colors.uDarkGrey }
        }
    ]

    function deselect()
    {
        tab.state = "NORMAL"
    }
    function select()
    {
        tab.state = "SELECTED"
    }

    transitions: [
        Transition {
            from: "NORMAL"
            to: "HOVERED"
            ColorAnimation { target: mainRectangle; duration: animationTime }
            ColorAnimation { target: subRectangle; duration: animationTime }
        },
        Transition {
            from: "NORMAL"
            to: "SELECTED"
            ColorAnimation { target: mainRectangle; duration: animationTime }
            ColorAnimation { target: subRectangle; duration: animationTime }
        },
        Transition {
            from: "HOVERED"
            to: "NORMAL"
            ColorAnimation { target: mainRectangle; duration: animationTime }
            ColorAnimation { target: subRectangle; duration: animationTime }
        },
        Transition {
            from: "HOVERED"
            to: "SELECTED"
            ColorAnimation { target: mainRectangle; duration: animationTime }
            ColorAnimation { target: subRectangle; duration: animationTime }
        },
        Transition {
            from: "SELECTED"
            to: "HOVERED"
            ColorAnimation { target: mainRectangle; duration: animationTime }
            ColorAnimation { target: subRectangle; duration: animationTime }
        },
        Transition {
            from: "SELECTED"
            to: "NORMAL"
            ColorAnimation { target: mainRectangle; duration: animationTime }
            ColorAnimation { target: subRectangle; duration: animationTime }
        }
    ]

    UFontAwesome {
        id: icon
        iconId: tab.iconId
        iconSize: tab.iconSize
        iconColor: _colors.uWhite

        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onHoveredChanged: {
            if(tab.state !== "SELECTED") {
                tab.state = (containsMouse ? "HOVERED" : "NORMAL")
            }
        }
        onClicked: {
            tab.clicked(tab)
            tab.state = "SELECTED"
        }
    }

    Component {
        id: leftTab
        Rectangle {
            id: area
            width: tab.width
            height: tab.height
            color: _colors.uMediumLightGrey
            radius: 5
            Rectangle {
                id: area2
                width: tab.width / 2
                height: tab.height
                anchors.right: parent.right
                color: _colors.uMediumLightGrey
            }
        }
    }
}
