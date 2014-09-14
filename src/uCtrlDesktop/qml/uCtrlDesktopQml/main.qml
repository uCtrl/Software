import QtQuick 2.0
import QtQuick.Controls 1.0

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

    property int scrollbarSize: 16

    property var activeModel: null
    property var activeComponent: null
    property var activePage: null

    property int radiusSize: 2

    // Frame dimension
    width: 1000; height: 650

    color: _colors.uLightGrey

    // Object Signals declaration
    signal swap (string page, string title, variant model)
    onSwap: renderComponent(page, title, model)

    // Extern Signals declarationb
    Component.onCompleted: {
        renderComponent(_paths.uLandingPage, _paths.uLandingPageTitle)
        highlightNavbar("Home")
    }

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

            activePage.anchors.top = titlebar.bottom
            activePage.anchors.bottom = main.bottom
            activePage.anchors.left = navbar.right
            activePage.anchors.right = main.right

            validatePage(model)
        } else {
            displayComponentError()
        }
    }

    function resetBreadcrumb() {
        titlebar.resetBreadcrumb()
    }

    function renderComponent(path, title, model) {
        titlebar.changeBreadcrumb(path, title, model)
        activeModel = model
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

    function getAreaWidth() {
        return main.width - (navbar.width + scrollbarSize)
    }

    function getAreaHeight() {
        return main.height - (titlebar.height + scrollbarSize)
    }

    function highlightNavbar(buttonNameToHighlight) {
        navbar.resetButtonHighlight()
        navbar.highlightButton(buttonNameToHighlight)
    }

    FontLoader { id: latoBold;          source: "qrc:///Resources/Fonts/Lato-Bold.ttf" }
    FontLoader { id: latoBoldItalic;    source: "qrc:///Resources/Fonts/Lato-BoldItalic.ttf" }
    FontLoader { id: latoItalic;        source: "qrc:///Resources/Fonts/Lato-Italic.ttf" }
    FontLoader { id: latoLight;         source: "qrc:///Resources/Fonts/Lato-Light.ttf" }
    FontLoader { id: latoLightItalic;   source: "qrc:///Resources/Fonts/Lato-LightItalic.ttf" }
    FontLoader { id: latoRegular;       source: "qrc:///Resources/Fonts/Lato-Regular.ttf" }

    Titlebar.Titlebar {
        id: titlebar

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        z: 1    // Always on top.
    }

    Navbar.UNavbar {
        id: navbar

        anchors.top: titlebar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        z: 1    // Always on top.
    }

    ScrollView {
        id: scrollView

        anchors.top: titlebar.bottom
        anchors.left: navbar.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        contentItem: Rectangle {
            id: frame

            color: _colors.uTransparent
        }
    }

    UI.UColors {
        id: _colors
    }

    UI.UPath {
        id: _paths
    }

    Timer {
        id: refreshTimer;
        interval: 5000;
        running: true;
        repeat: true;

        onTriggered: parent.refreshPage(parent.activeModel)
    }
}
