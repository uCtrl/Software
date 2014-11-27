import QtQuick 2.0
import QtQuick.Controls 1.0


import "component" as Components
import "ui" as Ui
import "ui/UColors.js" as Colors
import "resources/AndroidResource.js" as AndroidResource
import "resources/WindowsResource.js" as WindowsResource
import OSEnums 1.0

Rectangle {
    id: main

    Rectangle{
        id: resourceLoader

        function loadResource(resourceName){
            switch(uOSHandler.getOS()){
                case OsType.Android:
                    return AndroidResource.loadResource(resourceName)
                case OsType.Windows:
                    return WindowsResource.loadResource(resourceName)
            }
        }
    }

    // Frame configuration
    height: 800
    width: 1200

    color: Colors.uLightGrey
    // Available pages
    property variant pages: [
        {file: "home/ULandingPage", icon: "Dashboard", text: "Dashboard", showInNavBar: true},
        {file: "platform/Platforms", icon: "settings", text: "Platforms", showInNavBar: true},
        {file: "voice/VoiceControl", icon: "Microphone", text: "Voice Control", showInNavBar: true},
        {file: "device/Device", icon: "", text: "Device", showInNavBar: false},
        {file: "recommendations/Recommendations", icon: "wand", text: "Recommendations", showInNavBar: true},
        {file: "settings/Settings", icon: "cog2", text: "Settings", showInNavBar: true}
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


    Ui.UAlert {
        id: alert
        anchors.top: titlebar.bottom
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


    function initBreadcrumb(){
        titlebar.initBreadcrumb()
    }

    function changePageFromHome(path){
        currentPage = path
        titlebar.showBreadcrumbPlatforms()
    }

    function addToBreadcrumbPlatforms(path, pageName){
        titlebar.addToBreadcrumbPlatforms(path, pageName)
    }

    function addToBreadcrumbDevices(path, pageName){
        titlebar.addToBreadcrumbDevices(path, pageName)
    }

    function resetBreadcrumbDevices(){
        titlebar.resetBreadcrumbDevices()
    }

    function resetBreadcrumbPlatforms(){
        titlebar.resetBreadcrumbPlatforms()
    }

    function hideBreadcrumbPlatforms(){
        titlebar.hideBreadcrumbPlatforms()
    }
    function showBreadcrumbPlatforms(){
        titlebar.showBreadcrumbPlatforms()
    }
    function moveBreadcrumbPlatforms(){
        titlebar.moveBreadcrumbPlatforms()
    }

}

