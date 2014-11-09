import QtQuick 2.0
import QtQuick.Controls 1.0


import "component" as Components
import "ui/UColors.js" as Colors

Rectangle {
    id: main

    // Frame configuration
    height: 600
    width: 1200

    color: Colors.uLightGrey

    // Available pages
    property variant pages: [
        {file: "home/ULandingPage", icon: "Dashboard", text: "Dashboard", showInNavBar: true},
        {file: "platform/Platforms", icon: "settings", text: "Platforms", showInNavBar: true},
        {file: "voice/VoiceControl", icon: "Microphone", text: "Voice Control", showInNavBar: true},
        {file: "device/Device", icon: "", text: "Device", showInNavBar: false}
    ];

    property variant activeDevice: null
    property variant devicesList: null

    Components.Titlebar {
        id: titlebar

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        z: 2    // Always on top of the background and the navigation bar.

        pages: main.pages
    }

    Components.Navbar {
        id: navbar

        pages: main.pages

        anchors.top: titlebar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        z: 1    // Always on top of the background.
    }

    property string currentPage: "home/ULandingPage";

    Repeater {
        id: repeater

        model: pages;

        delegate: Loader {

            id: mainLoader

            active: false;
            asynchronous: true;

            anchors.left: navbar.right;
            anchors.right: parent.right;
            anchors.top: titlebar.bottom;
            anchors.bottom: parent.bottom;

            visible: (currentPage === modelData.file);
            source: "qrc:/qml/%1.qml".arg(modelData.file)
            onVisibleChanged:      { loadIfNotLoaded(); }
            Component.onCompleted: { loadIfNotLoaded(); }

            function loadIfNotLoaded () {
                // to load the file at first show
                if (visible && !active) {
                    active = true;
                }
            }
        }   
    }




    function changePageFromHome(path){
        currentPage = path
    }

    function addToBreadCrumbplatforms(path, pageName){
        titlebar.addToBreadCrumbplatforms(path, pageName)
    }

    function addToBreadCrumbdevices(path, pageName){
        titlebar.addToBreadCrumbdevices(path, pageName)
    }

    function resetBreadCrumbdevices(){
        titlebar.resetBreadCrumbdevices()
    }

    function resetBreadCrumbplatforms(){
        titlebar.resetBreadCrumbplatforms()
    }

    function hideBreadCrumbPlatforms(){
        titlebar.hideBreadCrumbPlatforms()
    }
    function showBreadCrumbPlatforms(){
        titlebar.showBreadCrumbPlatforms()
    }

}

