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

    function saveCondition() {
        // TODO : SET THE VALUE BITCH
        // weekDayCondition.selectedWeekdays = YOURSHITTYWIDGET.selectedWeekdays.value // FLAGS, SEE uconditionweekday.h
    }

    function cancelEditCondition() {
        // TODO : RESET THE VALUE BITCH
        // YOURSHITTYWIDGET.selectedWeekdays.text = weekDayCondition.selectedWeekdays
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
        width: 100

        text: "On"
    }

    // TODO: put your shit here
}
