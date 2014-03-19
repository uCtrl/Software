import QtQuick 2.0

import "UI" as UI

import "Navbar" as Navbar

import "DeviceConfiguration" as Config
import "Home" as Home
import "Statistics" as Stats
import "DeviceSummary" as Summary

Rectangle {
    id: main

    // Object properties
    property variant activeComponent: null
    property variant activePage: null

    width: 500; height: 800

    // Object Signals declaration
    signal swap (string page, string title, variant model)
    onSwap: renderComponent(page, title, model)

    signal menu (bool visible)
    onMenu: {
        var menuSize = 95
        if (!visible) menuSize *= -1
        activePage.move(0, menuSize)
    }

    // Extern Signals declaration
    Component.onCompleted: renderComponent(_paths.uHome, qsTr("Homepage"))

    // Object functions
    function destroyComponent() {
        if (activeComponent != null) activeComponent.destroy()
    }

    function displayComponentError() {
        if (activeComponent.status === Component.Error) {

            // @TODO : Replace with error alert.
            console.log("Error loading component:", activeComponent.errorString());
        }
    }

    function destroyPage() {
        if (activePage != null) activePage.destroy()
    }

    function refreshPage(model) {
        if (activeComponent.status === Component.Ready) {
            destroyPage()
            activePage = activeComponent.createObject(main)
            validatePage(model)
        } else {
            displayComponentError()
        }
    }

    function renderComponent(path, title, model) {
        navigationBar.title = title
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

    // Child objects
    Navbar.UNavbarWidget {
        id: navigationBar
        title: "Homepage"
        z: 1    // Always on top.
    }

    UI.UColors {
        id: _colors
    }

    UI.UPath {
        id: _paths
    }

    // Object states

    // Object transitions
}
