import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    property bool showConfig: false
    property bool showInfo: false
    property variant device: null

    height: 75; width: 500
    color: _colors.uLightGrey

    function getName() {
        return (device === undefined || device === null ? "UNKNOWN" : device.name)
    }

    function getRoom() {
        return (device === undefined || device === null ? "UNKNOWN" : "UNKNOWN")
    }

    function getImagePath() {
        var imagePaths = [ "a", "b", "c", "d"]
        return imagePaths[(device === undefined || device === null ? 0 : device.type)]
    }

    function refresh(newDevice) {
        device = newDevice
        textFrame.children[0].children[0].text = getName()
        textFrame.children[1].children[0].text = getRoom()
        iconLabel.text = getImagePath()
    }

    function swapConfig() {
        main.swap(_paths.uConfig, "Configuration", device)
    }

    function swapInfo() {
        main.swap(_paths.uInfo, "Information", device)
    }

    UI.UCircle {
        id: iconShadow

        height: 50
        width: 50
        color: _colors.uGrey

        anchors.top: parent.top
        anchors.topMargin: 14
        anchors.left: parent.left
        anchors.leftMargin: 21
    }

    UI.UCircle {
        id: iconFrame

        height: 50
        width: 50
        color: _colors.uWhite

        anchors.top: parent.top
        anchors.topMargin: 13
        anchors.left: parent.left
        anchors.leftMargin: 20

        // To be replaced by an icon
        ULabel.Default {
            id: iconLabel

            color: _colors.uGreen
            anchors.centerIn: parent

            font.pointSize: 15

            text: getImagePath()
        }
    }

    Rectangle {
        id: textFrame

        anchors.left: iconFrame.right
        anchors.leftMargin: 20
        height: parent.height
        width: parent.width - iconFrame.width - anchors.leftMargin
        color: _colors.uTransparent

        Rectangle {
            id: topTextFrame

            anchors.top: parent.top
            color: _colors.uTransparent
            width: parent.width
            height: parent.height/2 - 2

            UTitle {
                id: titleLabel
                anchors.bottom: parent.bottom
                text: getName()
            }

            UI.UButton {
                id: infoButton

                height: 15
                width: 20
                anchors.bottom: parent.bottom

                anchors.right: parent.right
                anchors.rightMargin: 37

                anchors.top: parent.top
                anchors.topMargin: 15

                text: "I"
                color: _colors.uGrey
                border.color: _colors.uGrey

                visible: showInfo

                function execute() {
                    swapInfo()
                }
            }
        }

        Rectangle {
            id: botTextFrame

            anchors.bottom: parent.bottom
            anchors.right: parent.right
            color: _colors.uTransparent
            width: parent.width
            height: parent.height/2 - 2

            USubtitle {
                anchors.top: parent.top
                id: subtitleLabel
                text: getRoom() //device.subtitle
            }

            UI.UButton {
                id: configButton

                height: 15
                width: 20
                anchors.top: parent.top

                anchors.right: parent.right
                anchors.rightMargin: 37

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15

                text: "C"
                color: _colors.uGrey
                border.color: _colors.uGrey

                visible: showConfig

                function execute() {
                    swapConfig()
                }
            }
        }
    }
}
