import QtQuick 2.0
import QtQuick.Controls 1.0

import "component" as Components
import "ui" as Ui
import "ui/UColors.js" as Colors

Rectangle {
    id: main

    // Frame configuration
    height: 600
    width: 1200

    color: Colors.uLightGrey

    // Available pages
    property variant pages: [
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

    property string currentPage: "platform/Platforms";

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
}

