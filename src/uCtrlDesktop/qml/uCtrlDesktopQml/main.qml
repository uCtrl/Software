import QtQuick 2.0

import "UI" as UI

import "Navbar" as Navbar

/*import "DeviceConfiguration" as Config
import "Home" as Home
import "Statistics" as Stats
import "DeviceSummary" as Summary*/

import "Titlebar" as Titlebar
import "Navbar" as Navbar

Rectangle {
    id: main

    // Frame dimension
    width: 900; height: 700

    color: "yellow"

    Titlebar.Titlebar {
        id: titlebar

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        z: 1    // Always on top.
    }

    Navbar.UNavBar {
        id: navbar

        anchors.top: titlebar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        z: 1    // Always on top.
    }

    Rectangle {
        id: frame

        anchors.left: navbar.right
        anchors.top: titlebar.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        color: _colors.uLightGrey
    }

    UI.UColors {
        id: _colors
    }

    UI.UPath {
        id: _paths
    }
}
