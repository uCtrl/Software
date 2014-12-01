import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors

Rectangle {
    id: platformsList

    color: Colors.uLightGrey

    property int marginSize: 20;
    property string section: "room";
    property string filterText: ""

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
            anchors.right: filters.right

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

        Rectangle
        {
            width: parent.width - 20
            height: parent.height - 20
            anchors.centerIn: parent
            clip: true

            color: Colors.uTransparent

            ListView {
                id: platforms

                anchors.fill: parent

                model: platformsModel

                Component.onCompleted: {
                    resetSelection()
                    main.pageChanged.connect(checkIfResetSelection)
                }

                function checkIfResetSelection(path, level)
                {
                    if(level === 0)
                        resetSelection()
                    if(level === 1 && path !== "platform/Platforms")
                        resetSelection()
                }

                function resetSelection()
                {
                    currentIndex = -1

                    platformInfo.showEditMode = false
                    platformInfo.model = null
                    platforms.currentIndex = -1
                }

                delegate: Column {
                    id: column

                    width: parent.width

                    PlatformListItem {
                        id: itemContainer

                        width: parent.width
                        height: 60

                        item: model

                        visible: (filterValue(item, filterText))

                        isSelected: platforms.currentIndex === index

                        MouseArea {
                            id: mouseArea

                            anchors.fill: parent
                            hoverEnabled: true

                            onClicked: {
                                platformInfo.showEditMode = false
                                platformInfo.model = model
                                platforms.currentIndex = index
                                main.addToBreadcrumb("platform/Platforms", model.name, 1)
                            }
                        }


                    }

                    function filterValue(source, filter) {
                        return (filter === ""
                                || source.name.toLowerCase().indexOf(filter.toLowerCase()) !== -1
                                || source.room.toLowerCase().indexOf(filter.toLowerCase()) !== -1)
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
