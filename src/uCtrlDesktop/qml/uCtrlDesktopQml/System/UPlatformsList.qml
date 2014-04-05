import QtQuick 2.0

Rectangle {
    id: list

    property var platforms: null
    property string filterValue: ""

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

        highlight: Rectangle {
            id: highlightBar

            visible: (systemContainer.activePlatform !== null)

            width: list.width; height: 60

            color: _colors.uUltraLightGrey

            y: (platformsList.currentItem === null ? -1 : platformsList.currentItem.y);
            Behavior on y { SpringAnimation { spring: 1; damping: 0.1 } }
        }
        highlightFollowsCurrentItem: false

        model: platforms
        delegate: Loader {
            sourceComponent: getSourceComponent()

            function getSourceComponent() {
                var platform = platforms.getPlatformAt(index)
                if (systemContainer.activePlatform === platform)
                    platformsList.currentIndex = index

                if (list.filterValue === "")
                    return platformContainer

                if (sourceContainsFilter(platform.name, filterValue)
                    || sourceContainsFilter(toString(platform.id), filterValue)
                    || sourceContainsFilter(platform.ip, filterValue)
                    || sourceContainsFilter(toString(platform.port), filterValue)
                    || sourceContainsFilter(platform.room, filterValue))
                    return platformContainer

                if (systemContainer.activePlatform === platform)
                    platformsList.currentIndex = -1

                return emptyComponent
            }

            function sourceContainsFilter (source, filter) {
                return source.toLowerCase().indexOf(filter.toLowerCase()) !== -1
            }

            Component {
                id: platformContainer

                UPlatform {
                    platformModel: platforms.getPlatformAt(index)
                    width: platformsList.width
                }
            }

            Component {
                id: emptyComponent

                Rectangle {
                    width: 0
                    height: 0
                }
            }
        }       
    }

    Component.onCompleted: {
        platformsList.currentIndex = -1
    }
}
