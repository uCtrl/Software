import QtQuick 2.0

Rectangle {
    id: menuButton

    color: _colors.uTransparent
    height: 25
    width: 25
    radius: 5

    function renderInformationMenu(visible) {
        menuFrame.createInfoMenu(visible)
    }

    function adjustTitle() {
        label.color = menuFrame.visible ? _colors.uGreen : _colors.uWhite
        menuButton.color = menuFrame.visible ? _colors.uWhite : _colors.uGreen
    }

    function toggleMenu() {
        displayMenu(!menuFrame.visible)
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
        color: _colors.uWhite
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
