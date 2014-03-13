import QtQuick 2.0

Rectangle {
    width: parent.width
    height: parent.height
    color: "white"

    anchors.top: parent.top
    anchors.topMargin: 40

    anchors.left: parent.left


    signal move(int x, int y)
    onMove: {
        for (var i=0; i<children.length;i++) {
            children[i].x += x
            children[i].y += y
        }
    }
}
