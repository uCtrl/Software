import QtQuick 2.0

Rectangle {
    height: 2
    width: parent.width
    color: _colors.uTransparent

    Rectangle {
        id: darkLine

        height: 1

        anchors.top: parent.top

        anchors.left: parent.left
        anchors.leftMargin: 3

        anchors.right: parent.right
        anchors.rightMargin: 3

        color: _colors.uBlack
        opacity: 0.4
    }

    Rectangle {
        id: ligthLine

        height: 1

        anchors.top: darkLine.bottom

        anchors.left: parent.left
        anchors.leftMargin: 3

        anchors.right: parent.right
        anchors.rightMargin: 3

        color: _colors.uWhite
        opacity: 0.1
    }
}
