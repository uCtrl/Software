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

    UI.UPath {
        id: paths
    }

    // Rectangle properties
    id: main
    width: 500
    height: 800

    // Reference values
    property int centered: 83
    property variant deviceConfiguration: null
    property variant activeComponent: null
    property variant activePage: null

    Navbar.UNavbarWidget {
        id: navigationBar
        title: "Homepage"
        z: 1
    }

    Component.onCompleted: renderComponent("./Home/UHome.qml")

    function destroyComponent() {
        if (activeComponent != null) activeComponent.destroy()
    }

    function destroyPage() {
        if (activePage != null) activePage.destroy()
    }

    function displayComponentError() {
        if (activeComponent.status == Component.Error) {
            // @TODO : Replace with error alert.
            console.log("Error loading component:", activeComponent.errorString());
        }
    }

    function refreshPage(model) {
        if (activeComponent.status == Component.Ready) {
            destroyPage()
            activePage = activeComponent.createObject(main)
            validatePage(model)
        } else {
            displayComponentError()
        }
    }

    function renderComponent(path, model) {
        destroyComponent()
        activeComponent = Qt.createComponent(path)
        refreshPage(model)
    }

    function setPageModel(model) {
        if (model !== undefined) {
            activePage.bind(model)
        } else if (activePage.requiredModel) {
            // @TODO : Replace with error alert.
            console.log("Error undefined model");
        }
    }

    function validatePage(model) {
        if (activePage == null) {
            // @TODO : Replace with error alert.
            console.log("Error creating object");
        } else {
            setPageModel(model)
        }
    }

    signal swap (string page, variant model)
    onSwap: { renderComponent(page, model) }

    signal menu (bool visible)
    onMenu: { }
}
