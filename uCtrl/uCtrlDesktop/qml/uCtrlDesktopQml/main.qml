import QtQuick 2.0

Rectangle {
    width: 360
    height: 600

    ListView {
        id: listContent
        anchors.top: deviceHeader.bottom
        height: 200
        width: parent.width
        spacing: 5

        model: myScenarioModel
        delegate: UConfigTaskWidget {}
        focus: true

        highlight: Rectangle
        {
            width: parent.width
            color: "lightsteelblue"
            radius: 5
        }
    }

    UConfigHeaderWidget {
        id: deviceHeader
        anchors.top: navigationBar.bottom
        img: "qrc:///Resources/Images/light_icon.png"
        title: "Lampe de chevet gauche"
        subtitle: "Chambre des maîtres"
    }

    UTitleWidget {
        title: "Configuration des modules"
        id:navigationBar
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
