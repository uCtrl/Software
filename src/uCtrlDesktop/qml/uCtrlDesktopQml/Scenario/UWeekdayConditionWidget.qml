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
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    property bool isEditMode: false

    function saveCondition() {
        weekDayCondition.selectedWeekdays = weekDayPicker.value
        weekDayPicker.closeDropDown()
        weekDayLabel.text = weekDayPicker.getText()
    }

    function cancelEditCondition() {
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
        anchors.leftMargin: 10

        anchors.verticalCenter: parent.verticalCenter
    }

    UI.UWeekDayPicker {
        id: weekDayPicker

        anchors.left: onLabel.right
        anchors.leftMargin: 10

        anchors.verticalCenter: parent.verticalCenter

        visible: isEditMode
    }

    ULabel.Default {
        id: weekDayLabel

        anchors.left: onLabel.right
        anchors.leftMargin: 10

        anchors.verticalCenter: parent.verticalCenter

        visible: !isEditMode
    }
}
