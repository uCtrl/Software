import QtQuick 2.0

import "../ui" as UI

Rectangle {

    id: platformsList

    color: "#EDEDED"

    property var marginSize: 20
    property string section: "room"

    Rectangle {
        id: filters

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: parent.marginSize

        height: 35
        width: (parent.width/2) - parent.marginSize

        color: "transparent"

        UI.UTextbox {
            id: searchBox

            anchors.left: filters.left
            anchors.leftMargin: 0

            anchors.right: filterCombo.left
            anchors.rightMargin: 5

            anchors.verticalCenter: filters.verticalCenter

            height: filters.height; width: 2 * (filters.width / 3);

            state: "ENABLED"

            opacity: 0.75

            placeholderText: "Search"

            iconId: "search"
            iconSize: 13

            /*onTextChanged: {
                platformListContainer.setFilter(searchBox.text)
            }*/
        }

        UI.UCombobox {
            id: filterCombo

            anchors.left: searchBox.right
            anchors.leftMargin: 5

            anchors.right: filters.right

            anchors.verticalCenter: filters.verticalCenter

            height: filters.height; width: (filters.width / 3);

            itemListModel: [
                { value: "room",     displayedValue: "Location",     iconId: "location"},
                { value: "update",   displayedValue: "Last Updated", iconId: "clock"},        // Not in model yet
                { value: "status",   displayedValue: "Status",       iconId: "switch"},       // Not in model yet
                { value: "type",     displayedValue: "Device type",  iconId: "spinner3"},     // Not in platform model yet, still exists in device.
                { value: "alphabet", displayedValue: "Name",         iconId: "Font"}
            ]

            /*onSelectedItemChanged: {
                platformListContainer.section = selectedItem.value
            }*/

            Component.onCompleted: {
                selectItem(0)
            }
        }
    }

    Rectangle {
        id: rectPlatforms

        anchors.top: filters.bottom
        anchors.bottom: parent.bottom

        anchors.left: parent.left

        anchors.margins: parent.marginSize

        width: filters.width

        color: "white"

        ListView {
            id: platforms

            anchors.fill: parent

            model: platformsModel

            highlight: Rectangle {
                id: highlighter

                width: parent.width; height: parent.height;

                color: "#D4D4D4"
                opacity: 0.6

                visible: (platformInfo.model != null)

                z: 2

                y: (platforms.currentIndex === null ? -1 : (platforms.currentIndex * 80) + 20);
                Behavior on y { SpringAnimation { spring: 5; damping: 0.1; mass: 0.3 } }
            }

            delegate: Column {
                width: parent.width
                z: 1
                Rectangle {
                    id: itemContainer

                    width: parent.width
                    height: 60

                    color: "white"

                    Rectangle {
                        width: parent.width - 10
                        height: platformName.height + platformUpdate.height

                        anchors.verticalCenter: parent.verticalCenter
                        x: 10

                        Text {
                            id: platformName

                            text: name

                            color: "black"

                            font.bold: true
                            font.pixelSize: 18

                            anchors.top: parent.top
                        }

                        Text {
                            id: platformUpdate

                            text: "Updated a second ago."

                            color: "#737373"

                            font.bold: false
                            font.pixelSize: 10

                            anchors.top: platformName.bottom
                        }
                    }

                    Rectangle {
                        id: platformSeparator

                        width: parent.width
                        height: 1

                        anchors.bottom: parent.bottom

                        color: "#D4D4D4"
                    }

                    MouseArea {
                        anchors.fill: parent
                        height: parent.height; width: parent.width;
                        onClicked: {
                            platformInfo.model = model
                            platforms.currentIndex = index
                           //highlighter.top = platforms.currentItem.top
                        }
                    }
                }
            }

            section.property: platformsList.section
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                id: header

                property bool showChildren: true

                width: parent.width; height: 20;

                color: "#0D9B0D"

                Text {
                    id: room
                    font.family: "Lato"
                    font.pointSize: 10
                    font.bold: true

                    text: section
                    color: "white"

                    anchors.left: parent.left
                    anchors.leftMargin: 5

                    anchors.verticalCenter: parent.verticalCenter
                }

                MouseArea {
                    id: headerArea

                    anchors.fill: parent

                    onClicked: header.showChildren = !header.showChildren
                }
            }
        }
    }

    Platform {
        id: platformInfo

        anchors.top: parent.top
        anchors.margins: parent.marginSize
        anchors.bottom: parent.bottom

        anchors.left: rectPlatforms.right
        anchors.right: parent.right

        width: (parent.width/2)
    }
}
