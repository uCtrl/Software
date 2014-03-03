import QtQuick 2.0


Rectangle {
    border.color: "gray"
    radius: 5
    height: message.height + (conditions.height > dragger.height ? conditions.height : dragger.height)
    width: parent.width-8
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: message
        anchors.top: parent.top
        anchors.left: parent.left
        color: "transparent"
        border.color: "red"
        Text {
//            anchors.margins: 5
            color: "blue"
//            text: "sadfasdf "+ id
            text: "Changer l'état pour <b><i>50%</b></i> quand:"

            font.family: "Helvetica neue"
            font.pointSize: 14
        }
    }

    Rectangle {
        id: conditions
        anchors.top: message.bottom
        anchors.left: parent.left
        height: conditionsContent.height
        color: "transparent"
        border.color: "blue"
        ListView {
            id:conditionsContent
            anchors.fill: parent
        }
    }

    Rectangle {
        id: dragger
        anchors.right: parent.right
        anchors.top: message.bottom
        width: 25
        height: 25
        color: "transparent"

        UImageWidget {
            anchors.centerIn: parent
            height: 15
            width: 15
            source: "qrc:///Resources/Images/drag.png"
        }
    }


}

