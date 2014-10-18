import QtQuick 2.0

import "../devices" as Devices
import "../ui" as UI

Rectangle {

    color: "transparent"
    property variant model: null
    property int marginSize: 20

    Rectangle {
        visible: (model == null)

        anchors.fill: parent
        anchors.margins: 20

        color: "transparent"

        Text {

            text: "Please select a platform"

            anchors.centerIn: parent

            font.pointSize: 28
            font.bold: true
            color: "#AAAAAA"
        }
    }

    Rectangle {
        id: informations

        visible: (model != null)

        anchors.fill: parent

        color: "white"

        Row {
            id: nameRow

            height: 40

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: marginSize

            Text {
                id: name

                width: (parent.width - editButton.width)

                text: getName()

                color: "black"

                font.bold: true
                font.pixelSize: 20

                anchors.verticalCenter: editButton.verticalCenter
            }

            UI.UButton {
                id: editButton

                iconId: "pencil"

                iconSize: 22

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                width: 40

                buttonTextColor: "#AAAAAA"
                buttonColor: "transparent"
                buttonHoveredTextColor: "#0D9B0D"
                buttonHoveredColor: "transparent"

                onClicked: {
                    console.log("edit");
                }
            }
        }

        Row {
            id: enabledRow

            anchors.top: nameRow.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 40

            Rectangle {
                color: "white"

                width: (parent.width / 2)
                height: parent.height

                Text {
                    text: "Enabled"

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20

                    color: "#AAAAAA"
                    font.pixelSize: 14
                    font.bold: false
                }
            }

            Rectangle {
                color: "white"

                width: (parent.width / 2)
                height: parent.height

                Text {
                    text: getEnabled()

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20

                    color: "black"
                    font.pixelSize: 14
                    font.bold: false
                }
            }
        }

        Row {
            id: roomRow

            anchors.top: enabledRow.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 40

            Rectangle {
                color: "white"

                width: (parent.width / 2)
                height: parent.height

                Text {
                    text: "Location"

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20

                    color: "#AAAAAA"
                    font.pixelSize: 14
                    font.bold: false
                }
            }

            Rectangle {
                color: "white"

                width: (parent.width / 2)
                height: parent.height

                Text {
                    text: getRoom()

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20

                    color: "black"
                    font.pixelSize: 14
                    font.bold: false
                }
            }
        }

        Rectangle {

            id: separator

            height: 0.5

            anchors.bottom: roomRow.bottom

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.leftMargin: 20
            anchors.rightMargin: 20

            color: "#D4D4D4"
        }

        Devices.Devices {
            id: rectDevice

            model: getDevices()

            anchors.top: separator.bottom
            anchors.bottom: parent.bottom

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.margins: 20

            width: filters.width
        }
    }

    function getName() {
        if (model != null) return model.name
        else return "Test"
    }

    function getEnabled() {
        if (model != null) return model.isEnabled
        else return "null"
    }

    function getRoom() {
        if (model != null) return model.room
        else return "null"
    }

    function getDevices() {
        if (model != null) return platforms.model.nestedModelFromId(model.id);
        else return null
    }
}
