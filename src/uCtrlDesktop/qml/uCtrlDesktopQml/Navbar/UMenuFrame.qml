import QtQuick 2.0

Item {
    function toggleMenu() {
        parent.toggleMenu()
    }

    Rectangle {
        color: "#0D9B0D"
        height: menuFrame.height + 1
        width: main.width

        anchors.left: parent.left
        anchors.leftMargin: -455

        anchors.top: parent.top
        anchors.topMargin: 33
    }

    Rectangle {
        id: menuFrame
        color: "white"
        height: 95
        width: main.width

        anchors.left: parent.left
        anchors.leftMargin: -455

        anchors.top: parent.top
        anchors.topMargin: 33

        function toggleMenu() {
            parent.toggleMenu()
        }

        UMenuItem {
            id: homePage
            y: 5
            itemLabel: "Accueil"
            pageName: paths.uHome
        }

        UMenuItem {
            id: deviceConfiguration
            y: 35
            itemLabel: "Configuration"
            pageName: paths.uSummary
        }

        UMenuItem {
            id: statistics
            y: 65
            itemLabel: "Statistiques"
            pageName: paths.uStatistics
        }
    }
}


