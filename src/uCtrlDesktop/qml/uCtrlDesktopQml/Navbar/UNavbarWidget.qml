import QtQuick 2.0
import "../UI" as UI

Rectangle { // NavBar
    property string title: "DEFAULT LOCATION"

    width: parent.width
    height: 40
    anchors.top: parent.top
    color: _colors.uGreen

    function toggleMenu() {
        if (backBtn.isVisible()) backBtn.toggleMenu()
    }

    function renderInformationMenu(visible) {
        backBtn.renderInformationMenu(visible)
    }

    UI.UImage {
        id: homeBtn
        width: 60
        height: 35

        anchors.top: parent.top
        anchors.topMargin: 3

        anchors.left: parent.left
        anchors.leftMargin: 25

        img: "qrc:///Resources/Images/uCtrl-small-white.png"
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
        width: parent.width
        height: parent.height
        anchors.left: parent.left
        color:_colors.uTransparent

        UI.ULabel {
            text: title
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            headerStyle: 1

            Component.onCompleted: color="white"
        }

    }
}
