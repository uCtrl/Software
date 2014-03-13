import QtQuick 2.0

Item {
    property string itemLabel: "Unknown"
    property string pageName: "homepage"

    function swap() {
        parent.toggleMenu()
        main.swap(pageName)
    }

    Rectangle {
        id: activeFrame
        color: "transparent"
        height: 25
        width: 25
        anchors.left: parent.left
        anchors.leftMargin: 5

        Text {
            x: 7
            text: "x"
            visible: (main.getActivePage() === pageName)
            color: colors.uGreen

            MouseArea {
                anchors.fill: parent
                onClicked: swap()
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: swap()
        }
    }

    Text {
        y: 2
        text: itemLabel
        anchors.left: activeFrame.right
        anchors.leftMargin: 5

        MouseArea {
            anchors.fill: parent
            onClicked: swap()
        }
    }

    MouseArea {
        anchors.fill: parent
        onClicked: swap()
    }
}
