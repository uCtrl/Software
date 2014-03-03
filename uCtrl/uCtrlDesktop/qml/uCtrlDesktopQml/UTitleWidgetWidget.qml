import QtQuick 2.0

Rectangle { // NavBar
    property string title: "DEFAULT LOCATION"

    width: parent.width
    height: 40
    anchors.top: parent.top
    color: "#53a358"

    Rectangle {
        id: backBtn
        width: 50 //backImg.width
        height: parent.height
        anchors.left: parent.left
        color:"transparent"

        Image {
            id: backImg
            anchors.centerIn: parent
            source: "qrc:///Resources/Images/Back.png"
        }
    }

    Rectangle {
        id: navText
        width: parent.width - backBtn.width - homeBtn.width
        height: parent.height
        anchors.left: backBtn.right
        color:"transparent"

        Text {
            color: "#404040"
            text: title
            font.family: "Helvetica neue"
            font.pointSize: 18
            font.bold: true
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            anchors.horizontalCenter: parent.horizontalCenter
        }

    }

    Rectangle {
        id: homeBtn
        width:50 //homeImg.width
        height: parent.height
        anchors.right: parent.right
        color:"transparent"

        UImageWidget {
            id: homeImg
            anchors.centerIn: parent
            source: "qrc:///Resources/Images/uCtrl-Icon.png"
        }
    }

}
