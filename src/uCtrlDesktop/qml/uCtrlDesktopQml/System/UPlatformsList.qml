import QtQuick 2.0

Rectangle {
    id: list

    property var platforms: null

    clip: true

    radius: 5

    color: _colors.uWhite

    function refresh(newPlatformsList) {
        platforms = newPlatformsList
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
        delegate: UPlatform { }
    }

    Component.onCompleted: {
        platformsList.currentIndex = -1
    }
}
