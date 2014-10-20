import QtQuick 2.0
import QtQuick.Controls 1.0

import "../titlebar" as Titlebar
import "../navbar" as Navbar

Rectangle {
    id: main

    // Frame configuration
    height: 600
    width: 1200

    // @TODO    Replace with color library
    color: "#EDEDED"

    // Available pages
    property variant pages: [
        {file: "platform/Platforms", icon: "settings", text: "Platforms", showInNavbar: true},
        {file: "device/Device", icon: "", text: "Device", showInNavbar: false}
    ];

    property variant activeDevice: null

    Titlebar.Titlebar {
        id: titlebar

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        z: 2    // Always on top of the background and the navigation bar.
    }

    Navbar.Navbar {
        id: navbar

        pages: main.pages

        anchors.top: titlebar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        z: 1    // Always on top of the background.
    }

    property string currentPage: "platform/Platforms";

    Repeater {
        id: repeater

        model: pages;

        delegate: Loader {

            id: mainLoader

            property variant test: null

            active: false;
            asynchronous: true;

            anchors.left: navbar.right;
            anchors.right: parent.right;
            anchors.top: titlebar.bottom;
            anchors.bottom: parent.bottom;

            visible: (currentPage === modelData.file);
            source: "qrc:/%1.qml".arg(modelData.file)
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

    /*Text {
        id: sceLabel
        anchors.top: devRect.bottom
        text: "SCENARIOS"
        color: "red"
    }

    Rectangle {
        id: sceRect
        anchors.top: sceLabel.bottom
        height: 100
        ListView {
            id: scenarios
            anchors.fill: parent
            model: ""
            delegate: Column {
                width: parent.width
                height: 20

                Text {
                    text: id + " | " + name + " | " + active
                    wrapMode: Text.WordWrap
                    MouseArea {
                        anchors.fill: parent
                        height: parent.height; width: parent.width;
                        onClicked: {
                            console.log(id);
                            tasks.model = scenarios.model.nestedModelFromId(model.id);
                        }
                    }
                }
            }
        }
    }

    Text {
        id: tasLabel
        anchors.top: sceRect.bottom
        text: "TASKS"
        color: "purple"
    }

    Rectangle {
        id: tasRect
        anchors.top: tasLabel.bottom
        height: 100
        ListView {
            id: tasks
            anchors.fill: parent
            model: ""
            delegate: Column {
                width: parent.width
                height: 20

                Text {
                    text: id + " | " + suspended + " | " + name + " | " + status
                    wrapMode: Text.WordWrap
                    MouseArea {
                        anchors.fill: parent
                        height: parent.height; width: parent.width;
                        onClicked: {
                            conditions.model = tasks.model.nestedModelFromId(model.id);
                        }
                    }
                }
            }
        }
    }

    Text {
        id: conLabel
        anchors.top: tasRect.bottom
        text: "CONDITIONS"
        color: "yellow"
    }

    Rectangle {
        id: conRect
        anchors.top: conLabel.bottom
        height: 100
        ListView {
            id: conditions
            anchors.fill: parent
            model: ""
            delegate: Column {
                width: parent.width
                height: 20

                Text {
                    text: id
                    wrapMode: Text.WordWrap
                }
            }
        }
    }
    */
}

