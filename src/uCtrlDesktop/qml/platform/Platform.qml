import QtQuick 2.0

import "../device" as Device
import "../label" as ULabel
import "../ui" as UI

Rectangle {

    color: "transparent"
    property variant model: null
    property int marginSize: 20

    property bool showAdvanced: false
    property bool showEditMode: false

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

            visible : !showEditMode

            ULabel.Default {
                id: nameLabel

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

                onClicked: toggleEditMode()
            }
        }

        Row {
            id: editNameRow

            anchors.fill: nameRow

            visible: showEditMode

            UI.UTextbox {
                id: nameTextbox

                anchors.top: parent.top

                height: 32
                width: (4 * (parent.width /5) + 20)

                text: getName()
                placeholderText: "Platform name"

                function validate() {
                    return text !== ""
                }

                state: (validate() ? "SUCCESS" : "ERROR")
                //onTextChanged: { platformValidator.validate() }
            }

            UI.USaveCancel {
                id: saveCancelPlatform

                anchors.top: parent.top

                width: parent.width / 5

                onSave: saveForm()
                onCancel: toggleEditMode()
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

                    visible: !showEditMode
                }

                UI.USwitch {
                    id: enabledSwitch

                    state: getEnabled()

                    anchors.left: enabledStatusLabel.left
                    anchors.top: enabledStatusLabel.top

                    visible: showEditMode
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
                    id: roomLabel

                    text: getRoom()

                    anchors.verticalCenter: parent.verticalCenter

                    anchors.left: parent.left
                    anchors.right: parent.right

                    anchors.margins: 20

                    visible: !showEditMode
                }

                UI.UTextbox {
                    id: roomTextbox

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.rightMargin: 20

                    anchors.verticalCenter: parent.verticalCenter

                    height: 25

                    visible: showEditMode

                    placeholderText: "Enter a location"
                    text: getRoom()
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

        Rectangle {
            id: advanced

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.margins: 20
            anchors.bottomMargin: 10

            height: showAdvanced ? 100 : 30

            color: "#EDEDED"

            border.width: 0.5
            border.color: "transparent"
            radius: 4

            Row {
                id: idRow

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top

                anchors.margins: 10

                height: 15

                visible: showAdvanced

                ULabel.Default {
                    width: (parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: "Platform ID"
                }

                ULabel.Default {
                    width: 3*(parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: getId()
                }
            }

            Row {
                id: ipRow

                anchors.left: idRow.left
                anchors.right: idRow.right
                anchors.top: idRow.bottom

                height: 15

                visible: showAdvanced

                ULabel.Default {
                    width: (parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: "IP Address"
                }

                ULabel.Default {
                    width: 3*(parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: getIp()
                }
            }

            Row {
                id: portRow

                anchors.left: ipRow.left
                anchors.right: ipRow.right
                anchors.top: ipRow.bottom

                height: 15

                visible: showAdvanced

                ULabel.Default {
                    width: (parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: "Port Number"
                }

                ULabel.Default {
                    width: 3*(parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: getPort()
                }
            }

            Row {
                id: firmwareRow

                anchors.left: portRow.left
                anchors.right: portRow.right
                anchors.top: portRow.bottom

                height: 15

                visible: showAdvanced

                ULabel.Default {
                    width: (parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: "Firmware Version"
                }

                ULabel.Default {
                    width: 3*(parent.width / 4); height: parent.height

                    color: "#AAAAAA"
                    font.family: "Courier"
                    font.pointSize: 11

                    text: getFirmwareVersion()
                }
            }

            UI.UFontAwesome {
                id: advancedIcon

                anchors.left: parent.left
                anchors.bottom: parent.bottom

                anchors.margins: 15

                iconId: "earth"
                iconSize: 12
                iconColor: "#AAAAAA"
            }

            ULabel.Default {
                id: advancedText

                text: (showAdvanced ? "Hide" : "Show") + " advanced information"

                anchors.left: advancedIcon.right
                anchors.leftMargin: 12
                anchors.verticalCenter: advancedIcon.verticalCenter

                font.family: "Courier"

                color: "#AAAAAA"
            }

            MouseArea {
                id: advancedMouseArea

                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                    advancedText.font.underline = containsMouse
                    advanced.border.color = (containsMouse ? "#AAAAAA" : "transparent")
                }

                onClicked: showAdvanced = !showAdvanced
            }
        }

        Device.Devices {
            id: rectDevice

            model: getDevices()

            anchors.top: separator.bottom
            anchors.bottom: advanced.top

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.margins: 20

            width: filters.width
        }
    }

    onModelChanged: if (showEditMode) toggleEditMode()

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

    function getId() {
        if (model != null) return model.id
        else return "null"
    }

    function getIp() {
        if (model != null) return model.ip
        else return "null"
    }

    function getPort() {
        if (model != null) return model.port
        else return "null"
    }

    function getFirmwareVersion() {
        if (model != null) return model.firmwareVersion
        else return "null"
    }

    function getDevices() {
        if (model != null) return platforms.model.nestedModelFromId(model.id);
        else return null
    }

    function saveForm() {
        if (nameTextbox.text != "") model.name = nameTextbox.text
        model.isEnabled = (enabledSwitch.state === "ON")
        model.room = roomTextbox.text

        toggleEditMode()
    }

    function toggleEditMode() {
        if (model != null) {
            nameTextbox.text = getName()
            enabledSwitch.state = getEnabled()
            roomTextbox.text = getRoom()
        }

        showEditMode = !showEditMode
    }
}
