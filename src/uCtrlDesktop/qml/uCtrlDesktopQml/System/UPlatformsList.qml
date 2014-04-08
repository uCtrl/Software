import QtQuick 2.0

Rectangle {
    id: list

    property var platforms: null
    property string filterValue: ""
    property string section: "room"

    clip: true

    radius: 5

    color: _colors.uWhite

    function refresh(newPlatformsList) {
        platforms = newPlatformsList
    }

    function setFilter(filter) {
        filterValue = filter
    }

    ListView {
        id: platformsList

        anchors.fill: parent

        model: systemPlatforms

        highlight: Rectangle {
            id: highlighter

            width: parent.width; height: 60;

            color: _colors.uUltraLightGrey

            visible: (systemContainer.activePlatform !== null)

            y: (platformsList.currentItem === null ? -1 : platformsList.currentItem.y);
            Behavior on y { SpringAnimation { spring: 1; damping: 0.1 } }

            Component.onCompleted: z=2
        }

        highlightFollowsCurrentItem: false

        delegate: UPlatform {
            id: repeated

            platformModel: reference

            width: platformsList.width

            Component.onCompleted:{ z=3; }
        }

        section.property: list.section
        section.criteria: ViewSection.FullString
        section.delegate: Rectangle {
            id: header

            property bool showChildren: true

            width: parent.width; height: 24;

            color: _colors.uGreen

            Text {
                id: room

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

        onModelChanged:{
            section.property = list.section
            section.criteria = ViewSection.FullString
        }
    }

    Component.onCompleted: {
        platformsList.currentIndex = 0
    }

    onSectionChanged: platformsList.section.property = section;
}
