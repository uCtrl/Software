import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: container

    property var platformModel: platformsList.model.getPlatformAt(index)
    property var system: systemFrame.system

    width: parent.width
    height: 60

    color: getBackgroundColor()

    state: "ENABLED"

    function getBackgroundColor() {
        switch (container.state) {
        case "ERROR":
            return _colors.uLightRed
        case "SELECTED":
            return _colors.uDarkGrey
        default:
            return _colors.uTransparent
        }
    }

    function getTextColor() {
        switch (container.state) {
        case "ERROR":
            return _colors.uDarkRed
        case "SELECTED":
            return _colors.uWhite
        default:
            return _colors.uDarkGrey
        }
    }

    function refresh(newPlatformModel) {
        platformModel = newPlatformModel;
    }

    UI.ULabel {
        id: platformTitle

        anchors.top: container.top
        anchors.topMargin: 13

        anchors.left: container.left
        anchors.leftMargin: 20

        text: container.platformModel.name
        color: getTextColor()

        headerStyle: 0
        Component.onCompleted: {
            font.pointSize = 18
            font.bold = true
            color = getTextColor()
        }
    }

    // @TODO: Hardcoded value, replace by true last update
    UI.ULabel {
        id: lastUpdate

        anchors.top: platformTitle.bottom
        anchors.left: platformTitle.left

        text: "3 hours ago"
        color: getTextColor()

        headerStyle: 0
        Component.onCompleted: {
            font.pointSize = 12
            color = getTextColor()
        }
    }

    Rectangle {
        property int marginSize: 3

        id: bottomLine

        width: container.width - (marginSize *2)
        height: 1

        anchors.left: container.left
        anchors.leftMargin: marginSize

        anchors.bottom: container.bottom
        anchors.bottomMargin: -1

        color: _colors.uLightGrey
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            var newIndex = -1
            var newPlatform = null

            if (systemContainer.activePlatform !== systemFrame.system.getPlatformAt(index)) {
                newIndex = index
                newPlatform = systemFrame.system.getPlatformAt(index)
            }

            refresh(newPlatform)
            platformsList.currentIndex = newIndex
            systemContainer.activePlatform = newPlatform
            platformInfo.refresh(newPlatform)
        }
    }

    onSystemChanged: refresh(system.getPlatformAt(index));
}
