import QtQuick 2.0
import "../UI" as UI

UI.UFrame {
    anchors.horizontalCenter: parent.horizontalCenter

    UHomeButton {
        id: homeButton
        x: centered
        y: 10
        buttonLabel: "Accueil"
        pageName: "homepage"
    }

    UHomeButton {
        id: configButton
        x: centered
        anchors.top: homeButton.bottom
        anchors.topMargin: 5
        buttonLabel: "Configuration"
        pageName: "summary"
    }

    UHomeButton {
        id: statButton
        x: centered
        anchors.top: configButton.bottom
        anchors.topMargin: 5
        buttonLabel: "Statistiques"
        pageName: "statistics"
    }
}
