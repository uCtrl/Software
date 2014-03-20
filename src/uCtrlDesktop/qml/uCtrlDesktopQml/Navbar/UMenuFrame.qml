import QtQuick 2.0

Item {
    property int menuHeight: 95

    function toggleMenu() {
        parent.toggleMenu()
    }

    /**
      function add to handle Information window
      */
    function createInfoMenu(visible) {
        information.visible = visible

        statistics.y = (visible? 95 : 65)

        if (visible)
            menuHeight = 125
        else
            menuHeight = 95
    }

    Rectangle {
        color: "#0D9B0D"
        height: menuHeight + 1
        width: main.width

        anchors.left: parent.left
        anchors.leftMargin: -455

        anchors.top: parent.top
        anchors.topMargin: 33
    }

    Rectangle {
        id: menuFrame

        color: "white"
        height: menuHeight
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
            id: information
            visible: false

            y: 65
            itemLabel: qsTr("Information")
            pageName: "Information"
            pagePath: _paths.uInfo
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


