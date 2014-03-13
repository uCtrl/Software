import QtQuick 2.0

Rectangle {
    id: menuButton
    color: "transparent"
    height: 25
    width: 25
    radius: 5

    function adjustTitle() {
        label.color = menuFrame.visible ? colors.uGreen : "white"
        menuButton.color = menuFrame.visible ? "white" : colors.uGreen
    }

    function toggleMenu() {
        displayMenu(!menuFrame.visible)
        main.menu(menuFrame.visible)
    }

    function displayMenu(status) {
        menuFrame.visible = status
        menuFrame.focus = status

        adjustTitle()
    }

    function isVisible() {
        return menuFrame.visible
    }

    Text {
        id: label
        color: "white"
        text: "M"
        font.family: "Helvetica neue"
        font.pointSize: 18
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
    }

    UMenuFrame {
        id: menuFrame
        visible: false
    }

    MouseArea {
        anchors.fill: parent
        onClicked: toggleMenu()
    }
}
