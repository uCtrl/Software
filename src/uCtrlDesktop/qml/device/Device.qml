import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel

Rectangle {

    id: deviceInfo

    anchors.fill: parent

    property variant model: main.activeDevice
    property bool showEditMode: false

    color: "transparent"

    Rectangle {
        id: deviceHeader

        property int marginSize: 20

        color: "white"

        anchors.top: parent.top
        anchors.left: parent.left

        anchors.margins: marginSize

        width: (parent.width / 2) - (marginSize * 2);
        height: 150

        Rectangle {
            id: icon

            anchors.top: parent.top
            anchors.left: parent.left

            anchors.margins: deviceHeader.marginSize

            height: 40; width: 40

            color: "#0D9B0D"

            radius: 4

            ULabel.Default {
                id: type

                anchors.centerIn: parent

                color: "white"

                font.pointSize: 18
                font.bold: false

                text: getType()
            }
        }

        Rectangle {
            id: buttonContainer

            anchors.right: parent.right
            anchors.top: parent.top

            anchors.margins: deviceHeader.marginSize

            width: showEditMode ? saveCancelPlatform.width : editButton.width

            anchors.verticalCenter: icon.verticalCenter

            UI.UButton {
                id: editButton

                iconId: "pencil"

                iconSize: 22

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                height: 40; width: 40

                buttonTextColor: "#AAAAAA"
                buttonColor: "transparent"
                buttonHoveredTextColor: "#0D9B0D"
                buttonHoveredColor: "transparent"

                onClicked: showEditMode = true

                visible: !showEditMode
            }

            UI.USaveCancel {
                id: saveCancelPlatform

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                onSave: saveForm()
                onCancel: toggleEditMode()

                visible: showEditMode
            }
        }

        Rectangle {
            id: nameContainer

            anchors.left: icon.right
            anchors.right: buttonContainer.left

            anchors.verticalCenter: icon.verticalCenter

            anchors.margins: 10

            ULabel.Default {
                id: nameLabel

                anchors.verticalCenter: parent.verticalCenter

                anchors.left: parent.left
                anchors.right: parent.right

                font.pointSize: 24
                font.bold: true

                color: "black"

                text: getName()

                visible: !showEditMode
            }

            UI.UTextbox {
                id: nameTextbox

                anchors.verticalCenter: parent.verticalCenter

                anchors.left: parent.left
                anchors.right: parent.right

                height: 40

                text: getName()
                placeholderText: "Enter device name"

                function validate() {
                    return text !== ""
                }

                visible: showEditMode

                state: (validate() ? "SUCCESS" : "ERROR")
            }
        }

        Rectangle {
            id: enabledContainer

            anchors.left: parent.left
            anchors.top: icon.bottom

            anchors.topMargin: deviceHeader.marginSize / 2

            height: 25; width: (parent.width / 2)

            ULabel.UInfoTitle {
                id: enabledTitle

                text: "STATUS"

                anchors.left: parent.left
                anchors.leftMargin: deviceHeader.marginSize

                anchors.verticalCenter: parent.verticalCenter;
                width: 150
            }

            ULabel.UInfoBoundedLabel {
                id: enabledStatusLabel
                text: getEnabled()

                anchors.left: enabledTitle.right
                anchors.verticalCenter: parent.verticalCenter

                visible: !showEditMode
            }

            UI.USwitch {
                id: enabledSwitch

                anchors.left: enabledTitle.right
                anchors.verticalCenter: parent.verticalCenter

                state: getEnabled()

                visible: showEditMode
            }
        }

        Rectangle {
            id: updateContainer

            anchors.right: parent.right
            anchors.verticalCenter: enabledContainer.verticalCenter

            height: 25; width: 220

            UI.UFontAwesome {
                id: updateIcon

                anchors.left: parent.left
                anchors.margins: 5
                anchors.verticalCenter: parent.verticalCenter

                iconSize: 14
                iconId: "Time"
                iconColor: "#AAAAAA"
            }

            ULabel.Default {
                id: updateText

                text: getUpdate()

                anchors.left: updateIcon.right
                anchors.right: parent.right

                anchors.margins: 12

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 14
                font.bold: false
                font.family: "Lato"

                color: "#AAAAAA"
            }
        }

        Rectangle {
            id: descriptionContainer

            anchors.left: parent.left
            anchors.leftMargin: deviceHeader.marginSize

            anchors.right: parent.right
            anchors.rightMargin: deviceHeader.marginSize

            anchors.top: updateContainer.bottom
            anchors.topMargin: (deviceHeader.marginSize / 2)

            anchors.bottom: parent.bottom

            ULabel.UInfoTitle {
                id: descriptionTitle

                text: "DESCRIPTION"

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                width: 150
            }

            ULabel.Link {
                id: descriptionLink

                text: "Show more"

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                color: descriptionTitle.color
            }

            ULabel.Default {
                id: descriptionLabel

                text: getDescription()

                anchors.left: descriptionTitle.right
                anchors.right: descriptionLink.left

                anchors.verticalCenter: parent.verticalCenter
                color: descriptionTitle.color
            }
        }
    }

    function getName() {
        if (model !== null) return model.name
        else return "Device name"
    }

    function getEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
    }

    function getType() {
        if (model !== null) return model.type
        else return 0
    }

    function getUpdate() {
        if (model !== null && model.lastUpdate !== undefined) return model.lastUpdate
        else return "Last update a second ago."
    }

    function getDescription() {
        if (model !== null) return model.description
        else return ""
    }

    function saveForm() {
        if (model !== null) {
            if (nameTextbox.text != "") model.name = nameTextbox.text
            model.isEnabled = (enabledSwitch.state === "ON")
        }

        toggleEditMode()
    }

    function toggleEditMode() {
        if (model !== null) {
            nameTextbox.text = getName()
            enabledSwitch.state = getEnabled()
        }

        showEditMode = !showEditMode
    }
}
