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
    property variant deviceModel: main.activeDevice
    property bool showEditMode: false
    property var editTaskFunction

    onItemChanged: {
        whenLabel.text = getConditions().rowCount > 0 ? " when" : " otherwise"
    }

    Rectangle {
        id: taskContainer

        width: parent.width
        height: 40
        color: Colors.uTransparent

        ULabel.Default {
            id: separator

            anchors.left: parent.left

            anchors.verticalCenter: parent.verticalCenter

            text: "Set to "

            font.bold: true
            font.pointSize: 14

            color: Colors.uGrey

        }


        Rectangle
        {
            id: valueContainer

            width: valueLabel.width
            height: valueLabel.height

            anchors.verticalCenter: parent.verticalCenter

            anchors.left: separator.right
            anchors.leftMargin: 3

            ULabel.UInfoBoundedLabel {
                id: valueLabel

                boundedColor: getValueColor()

                text: getValueLabel()
            }
        }

        ULabel.Default {
            id: whenLabel

            anchors.left: valueContainer.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: getConditions().rowCount > 0 ? " when" : " otherwise"

            color: Colors.uGrey

            font.bold: true
            font.pointSize: 14
        }

        Rectangle {
            id: buttonContainer

            property int iconSize: 20
            property int buttonSize: 30
            property int marginSize: 5

            anchors.top: parent.top
            anchors.right: parent.right

            width: editButton.width + deleteButton.width + moveUpButton.width + moveDownButton.width
            height: 30
            visible: showEditMode

            UI.UButton {
                id: editButton
                iconId: "pencil"
                iconSize: buttonContainer.iconSize
                width: buttonContainer.buttonSize
                anchors.left: parent.left

                buttonTextColor: Colors.uMediumDarkGrey
                buttonColor: Colors.uTransparent
                buttonHoveredTextColor: Colors.uDarkGrey
                buttonHoveredColor: Colors.uTransparent

                onClicked: editTask()
            }

            UI.UButton {
                id: moveUpButton
                iconId: "ArrowDown"
                iconSize: buttonContainer.iconSize
                width: buttonContainer.buttonSize
                anchors.left: editButton.right

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
    }

    Condition.Conditions {
        id: conditionsContainer
        showEditMode: container.showEditMode
        model: getConditions()
    }

    function editTask()
    {
        var task = tasks.model.findObject(item.id)
        container.editTaskFunction(task, task.getConditions())
    }

    function getUnitLabel()
    {
        if(deviceModel !== null) return deviceModel.unitLabel
        else return ""
    }

    function getValue() {
        if (item !== null) return item.value
        else return ""
    }

    function getConditions() {
        if (item !== null) return tasks.model.nestedModelFromId(item.id)
    }

    function deleteTask() {
        uCtrlApiFacade.deleteTask(tasks.model.findObject(item.id))
        tasks.model.removeRow(item.id)
    }

    function getValueLabel()
    {
        if(typeof(deviceModel) === "undefined")
            return ""

        switch(deviceModel.valueType)
        {
            case UEValueType.Switch:
                return (getValue() === "1" ? "ON" : "OFF")
            case UEValueType.UpDownSwitch:
                return (getValue() === "1" ? "UP" : "DOWN")
            case UEValueType.Color:
                return getValue()
            case UEValueType.Slider:
                return (getValue() * 100) + getUnitLabel()
            default:
                return getValue() + getUnitLabel()
        }
    }

    function getValueColor()
    {
        if(typeof(deviceModel) === "undefined")
            return Colors.uGreen

        switch(deviceModel.valueType)
        {
            case UEValueType.Color:
                return "#" + getValue()
            default:
                return Colors.uGreen
        }
    }

    function moveUp() {
        tasks.model.moveUp(index);
    }

    function moveDown() {
        tasks.model.moveDown(index);
    }
}
