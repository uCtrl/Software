import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: scenarioContainer

    property var model: null
    property bool showEditMode: false

    color: Colors.get("uTransparent")

    Rectangle {
        id: buttonContainer

        anchors.right: scenarioContainer.right
        anchors.top: scenarioContainer.top

        width: showEditMode ? saveCancelPlatform.width : editButton.width
        height: 40

        UI.UButton {
            id: editButton

            iconId: "pencil"
            iconSize: 22

            anchors.right: buttonContainer.right

            height: 40; width: 40

            buttonTextColor: Colors.get("uGrey")
            buttonColor: Colors.get("uTransparent")
            buttonHoveredTextColor: Colors.get("uGreen")
            buttonHoveredColor: Colors.get("uTransparent")

            onClicked: showEditMode = true

            visible: !showEditMode
        }

        UI.USaveCancel {
            id: saveCancelPlatform

            anchors.verticalCenter: buttonContainer.verticalCenter
            anchors.right: buttonContainer.right

            onSave: saveForm()
            onCancel: toggleEditMode()

            visible: showEditMode
        }
    }

    Rectangle {
        id: nameContainer

        anchors.top: scenarioContainer.top

        anchors.left: scenarioContainer.left
        anchors.right: buttonContainer.left

        height: 40

        ULabel.Default {
            id: nameLabel

            anchors.verticalCenter: nameContainer.verticalCenter

            anchors.left: nameContainer.left

            font.pointSize: 24
            font.bold: true

            color: Colors.get("uBlack")

            text: getName()

            visible: !showEditMode
        }

        UI.UTextbox {
            id: nameTextbox

            anchors.verticalCenter: nameContainer.verticalCenter

            anchors.left: nameContainer.left
            anchors.right: nameContainer.right

            height: 40

            text: getName()
            placeholderText: "Enter scenario name"

            function validate() {
                return text !== ""
            }

            visible: showEditMode

            state: (validate() ? "SUCCESS" : "ERROR")
        }

        Rectangle {
            id: updateContainer

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.top: nameContainer.bottom

            height: 25;

            color: Colors.get("uTransparent")

            UI.UFontAwesome {
                id: updateIcon

                anchors.left: parent.left
                anchors.leftMargin: 10

                anchors.verticalCenter: parent.verticalCenter

                iconSize: 14
                iconId: "Time"
                iconColor: Colors.get("uGrey")
            }

            ULabel.Default {
                id: updateText

                text: getUpdate()

                anchors.left: updateIcon.right
                anchors.leftMargin: 15

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 14
                font.bold: false
                font.family: "Lato"

                color: Colors.get("uGrey")
            }
        }

        Rectangle {
            id: enabledContainer

            anchors.left: parent.left
            anchors.right: parent.right

            anchors.top: updateContainer.bottom

            anchors.topMargin: 10

            height: 25;

            ULabel.UInfoTitle {
                id: enabledTitle

                text: "STATUS"

                anchors.left: parent.left
                anchors.leftMargin: 6

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
    }

    function getName() {
        if (model !== null) return model.name
        else return "Scenario name"
    }

    function getEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
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
