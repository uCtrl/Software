import QtQuick 2.0

Rectangle {
    id: list

    property string filterValue: ""
    property string section: "room"

    clip: true

    radius: radiusSize

    color: _colors.uWhite

    function setFilter(filter) {
        filterValue = filter
    }

    ListView {
        id: platformsList

        anchors.fill: parent

        model: systemPlatforms

        highlight: Rectangle {
            id: highlighter

            width: parent.width; height: 55;

            color: _colors.uMediumLightGrey
            opacity: 0.6

            visible: (systemContainer.activePlatform !== null)

            y: (platformsList.currentItem === null ? -1 : platformsList.currentItem.y);
            Behavior on y { SpringAnimation { spring: 5; damping: 0.1; mass: 0.3 } }
        }

        highlightFollowsCurrentItem: false

        delegate: Loader {
            sourceComponent: getSourceComponent()

            Component {
                id: platformContainer

                UPlatform {
                    platformModel: reference
                    width: platformsList.width
                }
            }

            Component {
                id: emptyComponent

                Rectangle { width: 0; height: 0 }
            }

            function sourceContainsFilter (source, filter) {
                return source.toLowerCase().indexOf(filter.toLowerCase()) !== -1
            }

            function getSourceComponent() {
                var platform = mySystem.getPlatformAt(index)

                if (systemContainer.activePlatform === platform) platformsList.currentIndex = index

                if (list.filterValue === "")
                    return platformContainer

                if (sourceContainsFilter(platform.name, filterValue)
                    || sourceContainsFilter(platform.id, filterValue)
                    || sourceContainsFilter(platform.ip, filterValue)
                    || sourceContainsFilter(toString(platform.port), filterValue)
                    || sourceContainsFilter(platform.room, filterValue))
                    return platformContainer

                if (systemContainer.activePlatform === platform)
                    platformsList.currentIndex = -1

                return emptyComponent
            }

        }

        section.property: list.section
        section.criteria: ViewSection.FullString
        section.delegate: Rectangle {
            id: header

            property bool showChildren: true

            width: parent.width; height: 20;

            color: _colors.uGreen

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
