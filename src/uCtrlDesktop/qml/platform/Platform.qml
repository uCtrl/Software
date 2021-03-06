import QtQuick 2.0

import "../device" as Device
import "../label" as ULabel
import "../ui" as UI
import "../ui/UColors.js" as Colors

Rectangle {

    id: platformInfo

    color: Colors.uTransparent

    property variant model: null
    property int marginSize: 20

    property bool showAdvanced: false
    property bool showEditMode: false

    Rectangle {
        id: selectPlatform

        visible: (model == null)

        anchors.fill: parent
        anchors.margins: 20

        color: Colors.uTransparent

        ULabel.Default {

            text: "Please select a platform"

            anchors.centerIn: parent

            font.pointSize: 28
            font.bold: true
            color: Colors.uGrey
        }
    }

    Rectangle {
        id: informations

        visible: (model != null)

        anchors.fill: parent

        color: Colors.uWhite

        Rectangle {
            id: nameContainer

            height: 40

            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: marginSize

            UI.UButton {
                id: editButton

                iconId: "pencil"

                iconSize: 22

                anchors.top: parent.top
                anchors.right: parent.right

                anchors.bottom: parent.bottom

                width: 40

                buttonTextColor: Colors.uGrey
                buttonColor: Colors.uTransparent
                buttonHoveredTextColor: Colors.uGreen
                buttonHoveredColor: Colors.uTransparent

                onClicked: toggleEditMode()

                visible : !showEditMode
            }

            ULabel.Default {
                id: nameLabel

                anchors.left: parent.left
                anchors.right: editButton.right
                anchors.verticalCenter: editButton.verticalCenter

                font.pointSize: 24
                font.bold: true

                color: Colors.uBlack

                text: getName()

                visible : !showEditMode
            }

            Rectangle
            {
                visible: showEditMode
                width: parent.width
                height: 30
                anchors.verticalCenter: parent.verticalCenter

                UI.USaveCancel {
                    id: saveCancelPlatform

                    height: parent.height

                    anchors.top: parent.top
                    anchors.right: parent.right

                    onSave: saveForm()
                    onCancel: toggleEditMode()

                    visible: showEditMode
                }

                UI.UTextbox {
                    id: nameTextbox

                    anchors.left: parent.left
                    anchors.right: saveCancelPlatform.left
                    anchors.rightMargin: 5

                    height: 30

                    text: getName()
                    placeholderText: "Platform name"

                    function validate() {
                        return text !== ""
                    }

                    state: (validate() ? "SUCCESS" : "ERROR")

                    visible: showEditMode
                }
            }
        }

        Rectangle {
            id: roomContainer

            anchors.top: nameContainer.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 40

            ULabel.UInfoTitle {
                id: locationTitle

                text: "Location"

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                anchors.margins: 20

                width: (parent.width / 4)
            }

            ULabel.Default {
                id: roomLabel

                text: getRoom()

                anchors.verticalCenter: parent.verticalCenter

                anchors.left: locationTitle.right
                anchors.right: parent.right

                visible: !showEditMode
            }

            UI.UTextbox {
                id: roomTextbox

                anchors.left: locationTitle.right

                anchors.right: parent.right
                anchors.rightMargin: 20

                anchors.verticalCenter: parent.verticalCenter

                height: 30

                visible: showEditMode

                placeholderText: "Enter a location"
                text: getRoom()
            }
        }

        Rectangle {

            id: separator

            height: 0.5

            anchors.bottom: roomContainer.bottom

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.leftMargin: 20
            anchors.rightMargin: 20

            color: Colors.uMediumLightGrey
        }

        Rectangle {
            id: advanced

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            anchors.margins: 20
            anchors.bottomMargin: 10

            clip: true

            height: 30

            color: Colors.uLightGrey

            border.width: 0.5
            border.color: Colors.uTransparent
            radius: 4

            NumberAnimation
            {
                id: expandAdvanced
                target: advanced
                properties: "height"
                duration: 200
                to: 120
                easing.type: Easing.InOutQuad
            }

            NumberAnimation
            {
                id: collapseAdvanced
                target: advanced
                properties: "height"
                duration: 200
                to: 30
                easing.type: Easing.InOutQuad
            }

            Rectangle
            {
                width: parent.width
                anchors.top: parent.top
                anchors.bottom: advancedLabel.top
                color: Colors.uTransparent

                clip: true

                Row {
                    id: idRow

                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top

                    anchors.margins: 10

                    height: 15

                    z: 1

                    ULabel.Default {
                        width: (parent.width / 4); height: parent.height

                        color: Colors.uGrey
                        font.family: "Courier"
                        font.pointSize: 11

                        text: "Platform ID"
                    }

                    ULabel.Default {
                        width: 3*(parent.width / 4); height: parent.height

                        color: Colors.uGrey
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

                    z: 1

                    ULabel.Default {
                        width: (parent.width / 4); height: parent.height

                        color: Colors.uGrey
                        font.family: "Courier"
                        font.pointSize: 11

                        text: "IP Address"
                    }

                    ULabel.Default {
                        width: 3*(parent.width / 4); height: parent.height

                        color: Colors.uGrey
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

                    z: 1

                    ULabel.Default {
                        width: (parent.width / 4); height: parent.height

                        color: Colors.uGrey
                        font.family: "Courier"
                        font.pointSize: 11

                        text: "Port Number"
                    }

                    ULabel.Default {
                        width: 3*(parent.width / 4); height: parent.height

                        color: Colors.uGrey
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

                    z: 1

                    ULabel.Default {
                        width: (parent.width / 4); height: parent.height

                        color: Colors.uGrey
                        font.family: "Courier"
                        font.pointSize: 11

                        text: "Firmware Version"
                    }

                    ULabel.Default {
                        width: 3*(parent.width / 4); height: parent.height

                        color: Colors.uGrey
                        font.family: "Courier"
                        font.pointSize: 11

                        text: getFirmwareVersion()
                    }
                }
            }

            Rectangle
            {
                id: advancedLabel
                width: parent.width
                height: 30
                color: Colors.uTransparent
                anchors.horizontalCenter: parent.horizontalCenter

                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2

                z: 2
                UI.UFontAwesome {
                    id: advancedIcon

                    anchors.left: parent.left
                    anchors.bottom: parent.bottom

                    anchors.margins: 15

                    iconId: "earth"
                    iconSize: 12
                    iconColor: Colors.uGrey
                }

                ULabel.Default {
                    id: advancedText

                    text: (showAdvanced ? "Hide" : "Show") + " advanced information"

                    anchors.left: advancedIcon.right
                    anchors.leftMargin: 12
                    anchors.verticalCenter: advancedIcon.verticalCenter
                    font.family: "Courier"

                    color: Colors.uGrey
                }
            }

            MouseArea {
                id: advancedMouseArea

                anchors.fill: parent
                hoverEnabled: true
                onHoveredChanged: {
                    advancedText.font.underline = containsMouse
                    advanced.border.color = (containsMouse ? Colors.uGrey : Colors.uTransparent)
                }

                onClicked: {
                    showAdvanced = !showAdvanced
                    if(showAdvanced)
                    {
                        collapseAdvanced.stop()
                        expandAdvanced.start()
                    }
                    else
                    {
                        collapseAdvanced.start()
                        expandAdvanced.stop()
                    }
                }
            }
        }

        Device.Devices {
            id: rectDevice

            model: getDevices()

            anchors.top: separator.bottom
            anchors.bottom: advanced.top

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.margins: 10

            width: filters.width
        }
    }

    onModelChanged: if (showEditMode) toggleEditMode()

    function getName() {
        if (model != null) return model.name
        else return "Test"
    }

    function getRoom() {
        if (model != null) return model.room
        else return "null"
    }

    function isLocalPlatform()
    {
        if (typeof(model) != "undefined" && model !== null) return model.isLocalPlatform
        else return false
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
        model.room = roomTextbox.text
        uCtrlApiFacade.putPlatform(platforms.model.findObject(model.id));

        toggleEditMode()
        main.addToBreadcrumb("platform/Platforms", model.name, 1)
    }

    function toggleEditMode() {
        if (model != null) {
            nameTextbox.text = getName()
            roomTextbox.text = getRoom()
        }

        showEditMode = !showEditMode
    }
}
