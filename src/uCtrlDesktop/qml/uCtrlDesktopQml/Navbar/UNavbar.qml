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

        anchors.top: parent.top

        anchors.left: parent.left
    }

    UMenuItem {
        id: device
        icon: "Wrench"
        label: "Platforms"

        path: _paths.uSummary
        model: myDevice

        anchors.top: dashboard.bottom

        anchors.left: parent.left
    }

    UMenuItem {
        id: statistics
        icon: "BarChart"
        label: "Statistics"

        path: _paths.uStatistics

        anchors.top: device.bottom

        anchors.left: parent.left
    }

    UMenuItem {
        id: config
        icon: "Cogs"
        label: "Configurations"

        path: _paths.uHome

        anchors.top: statistics.bottom

        anchors.left: parent.left

        showSeparator: false
    }
}
