import QtQuick 2.0
import "../UI" as UI

Rectangle { // NavBar
    property string title: "DEFAULT LOCATION"

    width: parent.width
    height: 40
    anchors.top: parent.top
    color: colors.uGreen

    function toggleMenu() {
        if (backBtn.isVisible()) backBtn.toggleMenu()
    }

    Rectangle {
        id: homeBtn
        x: 20
        y: 20
        color:"transparent"

        Image {
            id: homeImg
            anchors.centerIn: parent
            source: "qrc:///Resources/Images/icon-uctrl-white.png"
        }
    }

    UMenu {
        id: backBtn
        height: 35
        width: 35
        z: 1
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
    }

    Rectangle {
        id: navText
        width: parent.width - backBtn.width - homeBtn.width
        height: parent.height
        anchors.left: homeBtn.right
        color:"transparent"

        Text {
            color: "white"
            text: title
            font.family: "Helvetica neue"
            font.pointSize: 18
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }
}
