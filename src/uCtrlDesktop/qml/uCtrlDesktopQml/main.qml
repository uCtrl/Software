import QtQuick 2.0

import "UI" as UI

import "Navbar" as Navbar

import "DeviceConfiguration" as Config
import "Home" as Home
import "Statistics" as Stats
import "DeviceSummary" as Summary

Rectangle {
    // Singleton declaration
    UI.UColors {
        id: colors
    }

    id: main

    // Rectangle properties
    width: 500
    height: 800
    color: "#EEEEEE"

    // Reference values
    property int centered: 83
    property string activePage: "homepage"
    property variant deviceConfiguration: null

    signal swap (string page)
    onSwap: {
        refreshPage()

        switch (page) {
        case "homepage":
            switchHome()
            break
        case "summary":
            switchDeviceSummary()
            break
        case "statistics":
            switchStatistics()
            break
        }

        activePage = page
        if (navigationBar.children[1].isVisible()) {
            menu(true)
        }
    }

    signal menu (bool visible)
    onMenu: {
        var menuSize = 95
        if (!visible) menuSize *= -1

        switch (activePage) {
        case "homepage":
            homepage.move(0, menuSize)
            break
        case "summary":
            deviceSummary.move(0, menuSize)
            break
        case "statistics":
            statistics.move(0, menuSize)
            break
        }
    }

    // Functions
    function refreshPage() {
        homepage.visible = false
        deviceSummary.visible = false
        deviceConfiguration.visible = false
        statistics.visible = false
    }

    function switchHome() {
        navigationBar.title = "Accueil"
        homepage.visible = true
    }

    function switchDeviceConfiguration(device) {
        navigationBar.title = "Configuration"
        deviceConfiguration.refresh(device)
        deviceConfiguration.visible = true
    }

    function switchDeviceSummary() {
        navigationBar.title = "Liste des appareils"
        deviceSummary.visible = true
    }

    function switchStatistics() {
        navigationBar.title = "Statistics"
        statistics.visible = true
    }

    function getActivePage() {
        return activePage
    }

    Navbar.UNavbarWidget {
        id: navigationBar
        title: "Acceuil"
        z: 1
    }

    Home.UHome {
        id: homepage
        visible: true
    }

    Summary.UDeviceSummary {
        id: deviceSummary
        visible: false
    }

    Config.UDeviceConfigurationWidget {
        id: deviceConfiguration
        visible: false
    }

    Stats.UStatistics {
        id: statistics
        visible: false
    }
}
