import QtQuick 2.0


Rectangle {
    border.color: "gray"
    radius: 5
    height: 35
    width: parent.width-8
    anchors.horizontalCenter: parent.horizontalCenter


    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 5
        id: cellText
        color: "blue"
        text: "This is a config cell with id #" + id
        font.family: "Helvetica"
        font.pointSize: 20
    }
}

