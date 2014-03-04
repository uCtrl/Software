import QtQuick 2.0


Rectangle{
    property variant theModel: model
    property variant myIndex: index
    color: "gray"
    radius: 5
    height: 30 + conditions.height
    width: parent.width-8
    anchors.horizontalCenter: parent.horizontalCenter

    Rectangle {
        id: message
        anchors.top: parent.top
        anchors.left: parent.left
        height: msgText.height
        color: "red"
        Text {
            id: msgText
            color:"blue"
            text: "Changer l'état pour <b><i>50%</b></i> quand: " + myIndex

            font.family: "Helvetica neue"
            font.pointSize: 14
        }
    }

    Rectangle {
        id: conditions
        anchors.top: message.bottom
        anchors.left: parent.left
        height: (20) * conditionsContent.count
        border.color: "blue"

        ListView {
            id: conditionsContent
            height: parent.height
            spacing: 4
            model: listContent.model.GetTasks(myIndex) // utiliser listContent.model pour tester
            delegate: Text { text:"J'ai un élément!" }
        }
    }

    Rectangle {
        id: dragger
        anchors.right: parent.right
        anchors.top: message.bottom
        width: 25
        height: 25
        color: "transparent"

        Image {
            anchors.centerIn: parent
            height: 15
            width: 15
            source: "qrc:///Resources/Images/drag.png"
        }
    }
}

