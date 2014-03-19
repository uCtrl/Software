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
            itemLabel: qsTr("Homepage")
            pageName: "Homepage"
            pagePath: _paths.uHome
        }

        UMenuItem {
            id: deviceConfiguration

            y: 35
            itemLabel: qsTr("Configuration")
            pageName: "Configuration"
            pagePath: _paths.uSummary
        }

        UMenuItem {
            id: statistics

            y: 65
            itemLabel: qsTr("Statistics")
            pageName: "Statistics"
            pagePath: _paths.uStatistics
        }
    }
}


