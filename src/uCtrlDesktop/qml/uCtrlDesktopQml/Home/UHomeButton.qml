import QtQuick 2.0

Rectangle {
    property string buttonLabel: "Unknown"
    property string pageName: "Unknown"

    height: 25
    width: 200

    anchors.horizontalCenter: parent.horizontalCenter

    color: colors.uGreen

    Text {
        color: "white"
        width:parent.width
        height:parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: buttonLabel
        font.pointSize: 13
    }

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (navigationBar.children[1].isVisible()) main.menu(false)
            main.swap(pageName)
        }
    }
}
