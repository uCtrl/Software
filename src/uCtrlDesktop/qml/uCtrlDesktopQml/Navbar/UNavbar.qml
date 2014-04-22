import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: navbar

    width: 100

    color: _colors.uDarkGrey

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
        dashboard.state = "NORMAL"
        device.state = "NORMAL"
        statistics.state = "NORMAL"
        config.state = "NORMAL"
    }

    function highlightButton(buttonNameToHighlight) {
        switch(buttonNameToHighlight) {
        case "Home":
            dashboard.state = "SELECTED"
            break
        case "Configuration":
            device.state = "SELECTED"
            break
        case "Statistics":
            statistics.state = "SELECTED"
            break
        case "Settings":
            config.state = "SELECTED"
            break
        }
    }
}
