import QtQuick 2.0

import "../device" as Device
import "../label" as ULabel
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

        ULabel.Default {

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

            ULabel.Default {
                id: name

                width: (parent.width - editButton.width)
                anchors.verticalCenter: editButton.verticalCenter

                font.pointSize: 24
                font.bold: true

                color: "black"

                text: getName()
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

                width: (parent.width / 4)
                height: parent.height

                ULabel.UInfoTitle {
                    id: enabledTitle

                    text: "Enabled"

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20
                }
            }

            Rectangle {
                color: "white"

                width: 3 * (parent.width / 4)
                height: parent.height

                ULabel.UInfoBoundedLabel {
                    id: enabledStatusLabel
                    text: getEnabled()

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20
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

                width: (parent.width / 4)
                height: parent.height

                ULabel.UInfoTitle {
                    id: locationTitle

                    text: "Location"

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20
                }
            }

            Rectangle {
                color: "white"

                width: 3 * (parent.width / 4)
                height: parent.height

                ULabel.Default {
                    text: getRoom()

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.margins: 20
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

        Device.Devices {
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
        if (model != null && model.isEnabled) return "ON"
        else return "OFF"
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
