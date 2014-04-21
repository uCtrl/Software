import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: navbar

    width: 61

    color: _colors.uDarkGrey

    Rectangle {
        height: parent.width
        width: 1
        color: _colors.uDarkerGray

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
    }

    // Menu component
    UMenuItem {
        id: dashboard
        icon: "meter"
        label: "Dashboard"
        name: "Home"

        path: _paths.uLandingPage
        title: _paths.uLandingPageTitle

        anchors.top: parent.top

        anchors.left: parent.left
    }

    UMenuItem {
        id: device
        icon: "settings"
        label: "Platforms"
        name: "Configuration"

        path: _paths.uSystem
        title: _paths.uSystemTitle
        model: mySystem

        anchors.top: dashboard.bottom

        anchors.left: parent.left
    }

    UMenuItem {
        id: statistics
        icon: "bars"
        label: "Statistics"
        name: "Statistics"

        path: _paths.uStatistics
        title: _paths.uStatisticsTitle
        anchors.top: device.bottom

        anchors.left: parent.left
    }

    UMenuItem {
        id: config
        icon: "cog2"
        label: "Configurations"
        name: "Settings"

        path: _paths.uHome
        title: _paths.uHomeTitle

        anchors.top: statistics.bottom

        anchors.left: parent.left

        showSeparator: false
    }

    function resetButtonHighlight() {
        dashboard.state = ""
        device.state = ""
        statistics.state = ""
        config.state = ""
    }

    function highlightButton(buttonNameToHighlight) {
        switch(buttonNameToHighlight) {
        case "Home":
            dashboard.state = "ACTIVE"
            break
        case "Configuration":
            device.state = "ACTIVE"
            break
        case "Statistics":
            statistics.state = "ACTIVE"
            break
        case "Settings":
            config.state = "ACTIVE"
            break
        }
    }
}
