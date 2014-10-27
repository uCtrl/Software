import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../condition" as Condition
import "../ui/UColors.js" as Colors

import DeviceEnums 1.0

Column {
    id: container
    width: parent.width

    property var item: null
    property bool showEditMode: false

    Rectangle {
        id: taskContainer

        height: 30
        color: Colors.uLightGrey

        width: parent.width

        ULabel.Default {
            id: taskLabel

            anchors.left: parent.left
            anchors.leftMargin: 10

            anchors.verticalCenter: parent.verticalCenter

            text: "TASK"

            font.bold: false
            font.pointSize: 10

            color: Colors.uGrey
        }

        ULabel.Default {
            id: indexLabel

            anchors.left: taskLabel.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: "#" + (index + 1)

            font.bold: true
            font.pointSize: 10

            color: Colors.uGreen
        }

        ULabel.Default {
            id: separator

            anchors.left: indexLabel.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: " - SET TO "

            font.bold: true
            font.pointSize: 10

            color: Colors.uGrey

        }

        ULabel.Default {
            id: valueLabel

            anchors.left: separator.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: getValue()

            color: Colors.uGreen

            font.bold: true
            font.pointSize: 10
        }

        ULabel.Default {
            id: whenLabel

            anchors.left: valueLabel.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: " WHEN"

            color: Colors.uGrey

            font.bold: false
            font.pointSize: 10
        }
    }

    Rectangle {
        id: buttonContainer

        property int iconSize: 20
        property int buttonSize: 30
        property int marginSize: 5

        anchors.right: parent.right

        width: (showEditMode ? saveButton.width + cancelButton.width : editButton.width) + (deleteButton.width + moveUpButton.width + moveDownButton.width)

        color: Colors.uTransparent

        UI.UButton {
            id: saveButton
            iconId: "checkmark"
            iconSize: buttonContainer.iconSize
            width: buttonContainer.buttonSize
            buttonTextColor: Colors.uGreen
            buttonColor: Colors.uTransparent
            buttonHoveredTextColor: Colors.uDarkGreen
            buttonHoveredColor: Colors.uTransparent

            visible: showEditMode
            onClicked: saveForm()
        }

        UI.UButton {
            id: cancelButton
            iconId: "Remove"
            iconSize: buttonContainer.iconSize

            anchors.left: saveButton.right
            width: buttonContainer.buttonSize
            buttonTextColor: Colors.uRed
            buttonColor: Colors.uTransparent
            buttonHoveredTextColor: Colors.uDarkRed
            buttonHoveredColor: Colors.uTransparent

            visible: showEditMode
            onClicked: toggleEditMode()
        }

        UI.UButton {
            id: editButton
            iconId: "pencil"
            iconSize: buttonContainer.iconSize
            width: buttonContainer.buttonSize
            buttonTextColor: Colors.uMediumDarkGrey
            buttonColor: Colors.uTransparent
            buttonHoveredTextColor: Colors.uGreen
            buttonHoveredColor: Colors.uTransparent

            visible: !showEditMode
            onClicked: showEditMode = true
        }

        UI.UButton {
            id: moveUpButton
            iconId: "ArrowDown"
            iconSize: buttonContainer.iconSize
            width: buttonContainer.buttonSize
            anchors.left: showEditMode ? cancelButton.right : editButton.right

            buttonTextColor: Colors.uMediumDarkGrey
            buttonColor: Colors.uTransparent
            buttonHoveredTextColor: Colors.uDarkGrey
            buttonHoveredColor: Colors.uTransparent

            onClicked: moveUp()
        }

        UI.UButton {
            id: moveDownButton
            iconId: "ArrowUp"
            iconSize: buttonContainer.iconSize
            width: buttonContainer.buttonSize
            anchors.left: moveUpButton.right

            buttonTextColor: Colors.uMediumDarkGrey
            buttonColor: Colors.uTransparent
            buttonHoveredTextColor: Colors.uDarkGrey
            buttonHoveredColor: Colors.uTransparent

            onClicked: moveDown()
        }

        UI.UButton {
            id: deleteButton
            iconId: "Trash"
            iconSize: buttonContainer.iconSize
            width: buttonContainer.buttonSize
            anchors.left: moveDownButton.right

            buttonTextColor: Colors.uMediumDarkGrey
            buttonColor: Colors.uTransparent
            buttonHoveredTextColor: Colors.uRed
            buttonHoveredColor: Colors.uTransparent

            onClicked: deleteTask()
        }
    }

    Condition.Conditions {
        id: conditionsContainer
        model: getConditions()
    }

    function getValue() {
        if (item !== null) return item.value
        else return "ON"
    }

    function getConditions() {
        if (item !== null) return tasks.model.nestedModelFromId(item.id)
    }

    function saveForm() {
        if (item !== null) {
            //if (nameTextbox.text != "") model.name = nameTextbox.text
            //item.isEnabled = (enabledSwitch.state === "ON")
        }

        toggleEditMode()
    }

    function toggleEditMode() {
        if (item !== null) {
            //nameTextbox.text = getName()
            //enabledSwitch.state = getEnabled()
        }

        showEditMode = !showEditMode
    }

    function deleteTask() {
        console.log("delete")
    }

    function moveUp() {
        tasks.model.moveUp(index);
    }

    function moveDown() {
        tasks.model.moveDown(index);
    }
}
