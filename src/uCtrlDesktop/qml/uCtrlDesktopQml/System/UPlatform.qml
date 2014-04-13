import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property var platformModel: null
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
        platformTitle.text = container.platformModel.name
    }

    function getLastUpdate(platform) {
        if (platform !== null) {
            var time = platform.lastUpdate;
            var currentTime = new Date();

            // @TODO: Replace with alert display.
            if (Qt.formatDate(time) > Qt.formatDate(currentTime)) console.log("An error occured.");
            else if (Qt.formatDate(time) === Qt.formatDate(currentTime)) return "Updated a second ago.";
            else if (currentTime.getMinutes()-1 === time.getMinutes()) return "Updated a minute ago.";
            else if (currentTime.getHours()-1 === time.getHours()) return "Updated last hour.";
            else if (currentTime.getDate() === time.getDate()) return "Updated earlier today.";
            else if (currentTime.getDate()-1 === time.getDate()) return "Updated yesterday.";
            else if (currentTime.getMonth() === time.getMonth()) return "Updated " + (currentTime.getDate() - time.getDate()) + " days ago.";
            else if (currentTime.getMonth()-1 === time.getMonth()) return "Last month.";
            else if (currentTime.getYear()-1 === time.getYear()) return "Last year.";
        }
    }

    ULabel.Default {
        id: platformTitle

        anchors.top: container.top
        anchors.topMargin: 13

        anchors.left: container.left
        anchors.leftMargin: 20

        text: container.platformModel.name
        color: getTextColor()

        font.pointSize: 16
        font.bold: true
    }

    // @TODO: Hardcoded value, replace by true last update
    ULabel.Default {
        id: lastUpdate

        anchors.top: platformTitle.bottom
        anchors.left: platformTitle.left

        text: getLastUpdate(platformModel)
        color: getTextColor()

        font.pointSize: 12
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

    onSystemChanged: if (system !== null) refresh(system.getPlatformAt(index));
}
