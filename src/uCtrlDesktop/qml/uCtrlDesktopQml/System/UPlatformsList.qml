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

        model: platforms
        delegate: UPlatform { }
    }
}
