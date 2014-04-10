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

        path: _paths.uHome
        title: _paths.uHomeTitle

        anchors.top: parent.top

        anchors.left: parent.left
    }

    UMenuItem {
        id: device
        icon: "Wrench"
        label: "Platforms"

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

        path: _paths.uStatistics
        title: _paths.uStatisticsTitle
        anchors.top: device.bottom

        anchors.left: parent.left
    }

    UMenuItem {
        id: config
        icon: "Cogs"
        label: "Configurations"

        path: _paths.uHome
        title: _paths.uHomeTitle

        anchors.top: statistics.bottom

        anchors.left: parent.left

        showSeparator: false
    }
}
