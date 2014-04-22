import QtQuick 2.0

Rectangle {
    height: 1
    width: parent.width
    color: _colors.uTransparent

    Rectangle {
        id: darkLine

        height: 1

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        color: _colors.uMediumDarkGrey
    }
}
