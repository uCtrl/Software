import QtQuick 2.0

Rectangle {
    property string title: "DEFAULT LOCATION"

    width: parent.width
    height: navigationPane.height + titlePane.height
    anchors.top: parent.top
    color: "white"
    border.color: "black"
    border.width: 2

    Rectangle {
        id: navigationPane
        width: parent.width
        height: 50
        anchors.top: parent.top
        color: "transparent"

        Rectangle {
            id: homeBtn
            width:50 //homeImg.width
            height: parent.height
            color: "transparent"
            anchors.right: parent.right

            Image {
                id: homeImg
                anchors.centerIn: parent
                source: "qrc:///Resources/Images/uCtrl-Icon.png"
            }
        }

        Rectangle {
            id: backBtn
            width: 50 //backImg.width
            height: parent.height
            color: "transparent"
            anchors.left: parent.left

            Image {
                id: backImg
                anchors.centerIn: parent
                source: "qrc:///Resources/Images/Back.png"
            }
        }
    }

    Rectangle {
        id: titlePane
        width: parent.width
        height: 40
        anchors.top: navigationPane.bottom
        color: "transparent"

        ULabel {
            text: title
            color: "black"
            font.pointSize: 18
            font.bold: true
            anchors.centerIn: parent
        }
    }
}
