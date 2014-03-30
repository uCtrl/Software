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
        anchors.topMargin: 5

        anchors.left: parent.left
    }

    UMenuItem {
        id: device
        icon: "Wrench"
        label: "Plateforms"

        path: _paths.uSummary
        model: myDevice

        anchors.top: dashboard.bottom
        anchors.topMargin: 5

        anchors.left: parent.left
    }

    UMenuItem {
        id: statistics
        icon: "BarChart"
        label: "Statistics"

        path: _paths.uStatistics

        anchors.top: device.bottom
        anchors.topMargin: 5

        anchors.left: parent.left
    }

    UMenuItem {
        id: config
        icon: "Cogs"
        label: "Configurations"

        path: _paths.uHome

        anchors.top: statistics.bottom
        anchors.topMargin: 5

        anchors.left: parent.left

        showSeparator: false
    }
}
