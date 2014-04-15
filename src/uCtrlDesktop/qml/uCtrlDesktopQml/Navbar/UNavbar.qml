import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: navbar

    width: 100

    color: _colors.uDarkGrey

    // Menu component
    UMenuItem {
        id: dashboard
        icon: "Dashboard"
        label: "Dashboard"
        name: "Home"

        path: _paths.uLandingPage
        title: _paths.uLandingPageTitle

        anchors.top: parent.top

        anchors.left: parent.left
    }

    UMenuItem {
        id: device
        icon: "Wrench"
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
        icon: "BarChart"
        label: "Statistics"
        name: "Statistics"

        path: _paths.uStatistics
        title: _paths.uStatisticsTitle
        anchors.top: device.bottom

        anchors.left: parent.left
    }

    UMenuItem {
        id: config
        icon: "Cogs"
        label: "Configurations"
        name: "Settings"

        path: _paths.uHome
        title: _paths.uHomeTitle

        anchors.top: statistics.bottom

        anchors.left: parent.left

        showSeparator: false
    }

    function resetButtonHighlight() {
        dashboard.color = _colors.uTransparent
        dashboard.iconColor = _colors.uGrey
        device.color = _colors.uTransparent
        device.iconColor = _colors.uGrey
        statistics.color = _colors.uTransparent
        statistics.iconColor = _colors.uGrey
        config.color = _colors.uTransparent
        config.iconColor = _colors.uGrey
    }

    function highlightButton(buttonNameToHighlight) {
        switch(buttonNameToHighlight) {
        case "Home":
            dashboard.color = _colors.uLightGrey
            dashboard.iconColor = _colors.uDarkGrey
            break
        case "Configuration":
            device.color = _colors.uLightGrey
            device.iconColor = _colors.uDarkGrey
            break
        case "Statistics":
            statistics.color = _colors.uLightGrey
            statistics.iconColor = _colors.uDarkGrey
            break
        case "Settings":
            config.color = _colors.uLightGrey
            config.iconColor = _colors.uDarkGrey
            break
        }
    }
}
