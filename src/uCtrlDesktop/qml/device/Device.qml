import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel

Rectangle {

    id: deviceInfo

    property variant model: main.activeDevice
    property bool showEditMode: false

    color: "transparent"

    Rectangle {
        id: square

        color: "white"

        anchors.fill: parent
        anchors.margins: 20
    }

    Rectangle {
        id: separator

        anchors.horizontalCenter: parent.horizontalCenter

        anchors.top: square.top
        anchors.bottom: square.bottom

        anchors.margins: 20

        width: 1

        color: "#EDEDED"
    }

    Rectangle {
        id: information

        anchors.left: square.left
        anchors.right: separator.right
        anchors.top: square.top
        anchors.bottom: square.bottom

        anchors.margins: 20

        color : "transparent"

        Rectangle {
            id: icon

            anchors.top: parent.top
            anchors.left: parent.left
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
            anchors.right: parent.right

            anchors.top: nameContainer.bottom
            anchors.topMargin: 30

            height: 35

            ULabel.UInfoTitle {
                id: enabledTitle

                text: "Enabled"

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left

                width: (parent.width / 5)
            }

            ULabel.UInfoBoundedLabel {
                id: enabledStatusLabel
                text: getEnabled()

                anchors.verticalCenter: parent.verticalCenter
                anchors.left: enabledTitle.right

                visible: !showEditMode
            }

            UI.USwitch {
                id: enabledSwitch

                state: getEnabled()

                anchors.left: enabledStatusLabel.left
                anchors.verticalCenter: parent.verticalCenter

                visible: showEditMode
            }
        }

        Rectangle {
            id: updateContainer

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.top: enabledContainer.bottom

            height: 35

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
            id: tabsContainer

            anchors.top: updateContainer.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            UI.UTabs {
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter

                height: 30; width: 200

                items: [
                    {icon: "Off", value: "Configuration"},
                    {icon: "Time", value: "Log"},
                    {icon: "BarChart", value: "Statistics"}
                ]

                Component.onCompleted: selectedValue = "Configuration"
            }
        }
    }

    Rectangle {
        id: configuration

        anchors.left: separator.right
        anchors.right: square.right
        anchors.top: square.top
        anchors.bottom: square.bottom

        anchors.margins: 20

        color: "transparent"
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
