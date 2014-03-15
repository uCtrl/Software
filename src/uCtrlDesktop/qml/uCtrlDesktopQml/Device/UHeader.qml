import QtQuick 2.0
import "../UI" as UI


Rectangle {
    property bool showConfig: false
    property bool showInfo: false

    property variant device: null

    height: 75
    width: parent.width
    color: colors.uLightGrey

    x: 0
    y: 0

    function getName() {
        return (device === undefined || device === null ? "UNKNOWN" : device.name)
    }

    function getRoom() {
        return (device === undefined || device === null ? "UNKNOWN" : "UNKNOWN" /*device.room*/)
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

    UI.UCircle {
        id: iconShadow
        height: 50
        width: 50
        color: colors.uGrey

        anchors.top: parent.top
        anchors.topMargin: 14
        anchors.left: parent.left
        anchors.leftMargin: 21
    }

    UI.UCircle {
        id: iconFrame
        height: 50
        width: 50
        color: "white"

        anchors.top: parent.top
        anchors.topMargin: 13
        anchors.left: parent.left
        anchors.leftMargin: 20

        // To be replaced by an icon
        UI.ULabel {
            id: iconLabel
            color: colors.uGreen
            font.pointSize: 15
            anchors.bottom: parent.bottom
            anchors.centerIn: parent.Center
            anchors.horizontalCenter: parent.horizontalCenter

            anchors.top: parent.top
            anchors.topMargin: ((parent.height/2) - height/2) + 4

            text: getImagePath()
        }
    }

    Rectangle {
        id: textFrame
        anchors.left: iconFrame.right
        anchors.leftMargin: 20
        height: parent.height
        width: parent.width - iconFrame.width - anchors.leftMargin
        color: "transparent"

        Rectangle {
            id: topTextFrame
            anchors.top: parent.top
            color: "transparent"
            width: parent.width
            height: parent.height/2 - 2

            UTitle {
                id: titleLabel
                anchors.bottom: parent.bottom
                labelText: getName()
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

                labelText: "I"
                color: colors.uGrey

                visible: showInfo
            }
        }

        Rectangle {
            id: botTextFrame
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            color: "transparent"
            width: parent.width
            height: parent.height/2 - 2

            USubtitle {
                anchors.top: parent.top
                id: subtitleLabel
                labelText: getRoom() //device.subtitle
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

                labelText: "C"
                color: colors.uGrey

                visible: showConfig

                MouseArea {
                    anchors.fill: parent
                    onClicked: main.swap(paths.uConfig, device)
                }
            }
        }
    }
}
