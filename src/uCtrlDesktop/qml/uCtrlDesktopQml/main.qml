import QtQuick 2.0

Rectangle {
    width: 500
    height: 800
    color: "gray"

    UScenarioWidget {
        anchors.top: deviceHeader.bottom
        anchors.bottom: parent.bottom
        name: "Scenario #1 - Semaine de travail"
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

}
