import QtQuick 2.0
import ConditionEnums 1.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Item {
    property var weekDayCondition: null

    id: container

    width: parent.width - 30
    height: parent.height - 5

    anchors.left: parent.left
    anchors.leftMargin: 28
    anchors.verticalCenter: parent.verticalCenter

    property bool isEditMode: false

    function saveCondition() {
        weekDayCondition.selectedWeekdays = weekDayPicker.value
        weekDayPicker.closeDropDown()
        weekDayLabel.text = weekDayPicker.getText()
    }

    function cancelEditCondition() {
        if (!isEditMode) {
            return
        }

        weekDayPicker.value = weekDayCondition.selectedWeekdays
        weekDayPicker.closeDropDown()
    }

    UI.UFontAwesome {
        id: weekdayIcon

        width: parent.height
        height: parent.height

        iconId: "CalendarEmpty"
        iconSize: 16
        iconColor: _colors.uBlack
        anchors.left: parent.left
    }

    ULabel.Default {
        id: onLabel

        text: "On"
        anchors.left: weekdayIcon.right

        anchors.verticalCenter: parent.verticalCenter
    }

    UI.UWeekDayPicker {
        id: weekDayPicker

        anchors.left: onLabel.right
        anchors.leftMargin: 5

        anchors.verticalCenter: parent.verticalCenter

        value: weekDayCondition.selectedWeekdays

        Component.onCompleted: {
            updateDisplay()
            weekDayLabel.text = getText()
        }

        visible: isEditMode
    }

    ULabel.Default {
        id: weekDayLabel

        anchors.left: onLabel.right
        anchors.leftMargin: 5

        anchors.verticalCenter: parent.verticalCenter

        text: weekDayPicker.getText()

        visible: !isEditMode
    }
}
