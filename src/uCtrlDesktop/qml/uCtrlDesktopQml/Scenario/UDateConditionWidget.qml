import QtQuick 2.0
import ConditionEnums 1.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {

    property bool isEditMode: false

    id: container

    width: parent.width - 30
    height: parent.height - 5

    state: UEComparisonType.InBetween.toString()

    property var setWidgetDate
    property var saveWidgetDate

    anchors.left: parent.left
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    color: _colors.uTransparent

    function saveCondition() {
        console.log("Comparison type saved: ", container.state)
        conditionModel.comparisonType = parseInt(container.state)
        saveWidgetDate()

        updateConditionView()
    }

    function updateConditionView() {
        container.state = conditionModel.comparisonType.toString()
        comboSelect.selectItemByValue(container.state)

        var beginDate = conditionModel.beginDate
        var endDate = conditionModel.endDate

        setWidgetDate(beginDate, endDate)

        switch(container.state) {
            case UEComparisonType.InBetween.toString():
                dateLabel.text = "Between " + beginDate.toLocaleDateString() + " and " + endDate.toLocaleDateString()
                break
            case UEComparisonType.LesserThan.toString():
                dateLabel.text = "Before " + beginDate.toLocaleDateString()
                break
            case UEComparisonType.GreaterThan.toString():
                dateLabel.text = "After " + beginDate.toLocaleDateString()
                break
            case UEComparisonType.Not.toString():
                dateLabel.text = "Not between " + beginDate.toLocaleDateString() + " and " + endDate.toLocaleDateString()
                break
        }
        console.log("State ", container.state)
        console.log("DateLabel ", dateLabel.text)
    }

    Component.onCompleted: {
        updateConditionView()
    }

    UI.UFontAwesome {
        id: timeConditionIcon

        width: 30
        anchors.verticalCenter: parent.verticalCenter

        iconId: "Calendar"
        iconSize: 16
        iconColor: _colors.uBlack
        anchors.left: parent.left
    }

    Rectangle {
        id: readOnlyContent
        anchors.left: timeConditionIcon.right
        anchors.right: parent.right
        height: parent.height
        visible: !isEditMode

        color: _colors.uTransparent

        ULabel.Default {
            id: dateLabel
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: editContent

        anchors.left: timeConditionIcon.right
        anchors.right: parent.right
        height: parent.height
        visible: isEditMode

        color: _colors.uTransparent

        UI.UComboBox {
            id: comboSelect
            width: 130
            height: 30
            anchors.verticalCenter: parent.verticalCenter

            itemListModel: [
                { value:UEComparisonType.InBetween.toString(), displayedValue:"Between", iconId:""},
                { value:UEComparisonType.LesserThan.toString(), displayedValue:"Before", iconId:""},
                { value:UEComparisonType.GreaterThan.toString(), displayedValue:"After", iconId:""},
                { value:UEComparisonType.Not.toString(), displayedValue:"Not Between", iconId:""}
            ]

            onSelectValue: {
                container.state = selectedItem.value
            }

            Component.onCompleted: {
                selectItem(0)
            }
        }

        Rectangle {
            id: content
            anchors.left: comboSelect.right
            anchors.leftMargin: 5
            anchors.right: parent.right
            height: parent.height

            color: _colors.uTransparent

            Loader {
                id: contentLoader
                anchors.fill: parent

                sourceComponent: {
                    switch(container.state) {
                    case UEComparisonType.InBetween.toString():
                        return fromContentContainer
                    case UEComparisonType.LesserThan.toString():
                        return beforeContentContainer
                    case UEComparisonType.GreaterThan.toString():
                        return afterContentContainer
                    case UEComparisonType.Not.toString():
                        return notContentContainer
                    }
                }
            }
        }
    }

    Component {
        id: fromContentContainer

        Rectangle {
            id: fromContent
            anchors.fill: parent
            color: _colors.uTransparent
            visible: container.state === UEComparisonType.InBetween.toString()

            function setDates(beginDate, endDate) {
                fromStartDatePicker.selectedDate = beginDate
                fromEndDatePicker.selectedDate = endDate
            }

            function saveDates() {
                conditionModel.beginDate = fromStartDatePicker.selectedDate
                conditionModel.endDate = fromEndDatePicker.selectedDate
            }

            Component.onCompleted: {
                container.setWidgetDate = setDates
                container.saveWidgetDate = saveDates

                setDates(conditionModel.beginDate, conditionModel.endDate)
            }

            UI.UDatePicker {
                id: fromStartDatePicker
                anchors.verticalCenter: parent.verticalCenter
            }

            ULabel.Default {
                id: fromAndLabel
                text: "and"
                anchors.left: fromStartDatePicker.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }

            UI.UDatePicker {
                id: fromEndDatePicker
                anchors.left: fromAndLabel.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
    Component {
        id: beforeContentContainer

        Rectangle {
            id: beforeContent
            anchors.fill: parent
            color: _colors.uTransparent
            visible: container.state === UEComparisonType.LesserThan.toString()

            function setDates(beginDate, endDate) {
                beforeStartDatePicker.selectedDate = beginDate
            }

            function saveDates() {
                conditionModel.beginDate = beforeStartDatePicker.selectedDate
                conditionModel.endDate = new Date()
            }

            Component.onCompleted: {
                container.setWidgetDate = setDates
                container.saveWidgetDate = saveDates

                setDates(conditionModel.beginDate, conditionModel.endDate)
            }

            UI.UDatePicker {
                id: beforeStartDatePicker
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Component {
        id: afterContentContainer

        Rectangle {
            id: afterContent
            anchors.fill: parent
            color: _colors.uTransparent
            visible: container.state === UEComparisonType.GreaterThan.toString()

            function setDates(beginDate, endDate) {
                afterStartDatePicker.selectedDate = beginDate
            }

            function saveDates() {
                conditionModel.beginDate = afterStartDatePicker.selectedDate
                conditionModel.endDate = new Date()
            }

            Component.onCompleted: {
                container.setWidgetDate = setDates
                container.saveWidgetDate = saveDates

                setDates(conditionModel.beginDate, conditionModel.endDate)
            }

            UI.UDatePicker {
                id: afterStartDatePicker
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Component {
        id: notContentContainer

        Rectangle {
            id: notContent
            anchors.fill: parent
            color: _colors.uTransparent
            visible: container.state === UEComparisonType.Not.toString()

            function setDates(beginDate, endDate) {
                notStartDatePicker.selectedDate = beginDate
                notEndDatePicker.selectedDate = endDate
            }

            function saveDates() {
                conditionModel.beginDate = notStartDatePicker.selectedDate
                conditionModel.endDate = notEndDatePicker.selectedDate
            }

            Component.onCompleted: {
                container.setWidgetDate = setDates
                container.saveWidgetDate = saveDates

                setDates(conditionModel.beginDate, conditionModel.endDate)
            }

            UI.UDatePicker {
                id: notStartDatePicker
                anchors.verticalCenter: parent.verticalCenter
            }

            ULabel.Default {
                id: notAndLabel
                text: "and"
                anchors.left: notStartDatePicker.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter
            }

            UI.UDatePicker {
                id: notEndDatePicker
                anchors.left: notAndLabel.right
                anchors.leftMargin: 5
                anchors.verticalCenter: parent.verticalCenter

                color: _colors.uWhite
            }
        }
    }

    Component {
        id: emptyendDate

        Rectangle {
            width: 0
            height: 0
        }
    }
}
