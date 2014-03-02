import QtQuick 2.0

Rectangle {
    width: 360
    height: 600

    ListView {
        id: listContent
        anchors.top: deviceHeader.bottom
        height: 200
        width: parent.width
        transformOrigin: Item.Center

        model: myScenarioModel
        delegate: UConfigWidget{}
        focus: true

        highlight: Rectangle { color: "lightsteelblue"; radius: 5 }
    }

    UHeaderBarWidget {
        id: deviceHeader
        img: "qrc:///Resources/Images/light_icon.png"
        title: "Lampe de chevet gauche"
        subtitle: "Chambre des maîtres"
    }


    Rectangle {
        id: navigationBar
        width: parent.width
        height: 60
        anchors.top: parent.top
        color: "#6cb043"

        UImageWidget {
            //Back button
            id: backBtn
            anchors.left: parent.left
            anchors.top: parent.top
            source: "qrc:///Resources/Images/Back.png"
        }

        UImageWidget {
            id: homeBtn
            anchors.right: parent.right
            anchors.top: parent.top
            source: "qrc:///Resources/Images/uCtrl-Icon.png"
        }

        Rectangle {
            width: parent.width - backBtn.width - homeBtn.width
            border.color: "red"
            anchors.centerIn: parent

            Text {
                id: navigationTitle
                width: parent.width
                color: "#404040"
                text:"Configuration des modules"
                font.family: "Helvetica"
                font.pointSize: 20
                font.bold: true

            }
        }
    }


    Rectangle {
        id: simplebutton
        objectName: "btn"
        anchors.top: listContent.bottom
        color: "grey"
        width: 96; height: 27

        Text{
            id: buttonLabel
            anchors.centerIn: parent
            text: "Add a task"
        }

        signal qmlSignal()

        MouseArea{
            id: buttonMouseArea

            anchors.fill: parent
            onClicked: simplebutton.qmlSignal()
        }
    }
}
