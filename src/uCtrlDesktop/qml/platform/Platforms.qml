import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors

Rectangle {
    id: platformsList

    color: Colors.uLightGrey

    property int marginSize: 20;
    property string section: "room";
    property string filterText: ""

    property variant sections: [
        { value: "room",     displayedValue: "Location",     iconId: "location"},
        { value: "lastUpdate",   displayedValue: "Last Updated", iconId: "clock"},
        { value: "status",   displayedValue: "Status",       iconId: "switch"},
        { value: "type",     displayedValue: "Device type",  iconId: "spinner3"}
   ]

    Rectangle {
        id: filters

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: parent.marginSize

        height: 35
        width: (parent.width/2) - parent.marginSize

        color: Colors.uTransparent

        z: 2

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

            onTextChanged: {
                filterText = searchBox.text
            }
        }

        UI.UCombobox {
            id: filterCombo

            itemListModel: sections

            anchors.left: searchBox.right
            anchors.leftMargin: 5

            anchors.right: filters.right

            height: searchBox.height;
            Component.onCompleted: selectItem(0)
        }
    }

    Rectangle {
        id: rectPlatforms

        z: 1

        anchors.top: filters.bottom
        anchors.bottom: parent.bottom

        anchors.left: parent.left

        anchors.margins: parent.marginSize

        width: filters.width

        color: Colors.uWhite

        ListView {
            id: platforms

            anchors.fill: parent

            model: platformsModel

            highlight: Rectangle {
                id: highlighter

                width: parent.width; height: parent.height;

                color: Colors.uMediumLightGrey
                opacity: 0.6

                visible: (platformInfo.model != null)

                z: 2

                y: (platforms.currentIndex === null ? -1 : (platforms.currentIndex * (height + 20)) + 20);
                Behavior on y { SpringAnimation { spring: 5; damping: 0.1; mass: 0.3 } }
            }

            delegate: Column {
                id: column

                width: parent.width

                PlatformListItem {
                    id: itemContainer

                    width: parent.width
                    height: 60

                    item: model

                    visible: (filterValue(name, filterText))

                    MouseArea {
                        id: mouseArea

                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            platformInfo.model = model
                            platforms.currentIndex = index
                        }
                    }
                }

                function filterValue(source, filter) {
                    if (filter === "") return true
                    else return source.toLowerCase().indexOf(filter.toLowerCase()) !== -1
                }
            }

            section.property: platformsList.section
            section.criteria: ViewSection.FullString
            section.delegate: Rectangle {
                id: header

                property bool showChildren: true

                width: parent.width; height: 20;

                color: Colors.uGreen

                Text {
                    id: headerText

                    font.family: "Lato"
                    font.pointSize: 10
                    font.bold: true

                    text: section
                    color: Colors.uWhite

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
