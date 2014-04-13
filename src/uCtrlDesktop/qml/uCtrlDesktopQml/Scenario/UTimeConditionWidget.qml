import QtQuick 2.0
import ConditionEnums 1.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle{

    property var timeCondition: null

    property bool isEditMode: false

    id: container

    width: parent.width - 30
    height: parent.height - 5

    state: UEComparisonType.InBetween.toString()

    anchors.left: parent.left
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    color: _colors.uTransparent

    function saveCondition() {
        conditionModel.comparisonType = parseInt(container.state)

        switch(container.state) {
            case UEComparisonType.InBetween.toString():
                conditionModel.beginTime = fromStartDatePicker.currentValue
                conditionModel.endTime = fromEndDatePicker.currentValue
                break
            case UEComparisonType.LesserThan.toString():
                conditionModel.beginTime = beforeStartDatePicker.currentValue
                conditionModel.endTime = "00:00"
                break
            case UEComparisonType.GreaterThan.toString():
                conditionModel.beginTime = afterStartDatePicker.currentValue
                conditionModel.endTime = "00:00"
                break
            case UEComparisonType.Not.toString():
                conditionModel.beginTime = notStartDatePicker.currentValue
                conditionModel.endTime = notEndDatePicker.currentValue
                break
        }

        updateConditionView()
    }

    function updateConditionView() {
        container.state = conditionModel.comparisonType.toString()
        comboSelect.selectItemByValue(container.state)

        var beginTime = Qt.formatTime(conditionModel.beginTime, "HH:mm")
        var endTime = Qt.formatTime(conditionModel.endTime, "HH:mm")

        fromStartDatePicker.setCurrentValue(beginTime)
        fromEndDatePicker.setCurrentValue(endTime)

        beforeStartDatePicker.setCurrentValue(beginTime)

        afterStartDatePicker.setCurrentValue(beginTime)

        notStartDatePicker.setCurrentValue(beginTime)
        notEndDatePicker.setCurrentValue(endTime)

        switch(container.state) {
            case UEComparisonType.InBetween.toString():
                timeLabel.text = "Between " + beginTime + " and " + endTime
                break
            case UEComparisonType.LesserThan.toString():
                timeLabel.text = "Before " + beginTime
                break
            case UEComparisonType.GreaterThan.toString():
                timeLabel.text = "After " + beginTime
                break
            case UEComparisonType.Not.toString():
                timeLabel.text = "Not between " + beginTime + " and " + endTime
                break
        }
    }

    Component.onCompleted: {
        updateConditionView()
    }

    UI.UFontAwesome {
        id: timeConditionIcon

        width: 30
        anchors.verticalCenter: parent.verticalCenter

        iconId: "Time"
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
            id: timeLabel
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
        }

        Rectangle {
            id: content
            anchors.left: comboSelect.right
            anchors.leftMargin: 5
            anchors.right: parent.right
            height: parent.height

            color: _colors.uTransparent

            Rectangle {
                id: fromContent
                anchors.fill: parent
                color: _colors.uTransparent
                visible: container.state === UEComparisonType.InBetween.toString()

                UI.UTimePicker {
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

                UI.UTimePicker {
                    id: fromEndDatePicker
                    anchors.left: fromAndLabel.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Rectangle {
                id: beforeContent
                anchors.fill: parent
                color: _colors.uTransparent
                visible: container.state === UEComparisonType.LesserThan.toString()

                UI.UTimePicker {
                    id: beforeStartDatePicker
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Rectangle {
                id: afterContent
                anchors.fill: parent
                color: _colors.uTransparent
                visible: container.state === UEComparisonType.GreaterThan.toString()

                UI.UTimePicker {
                    id: afterStartDatePicker
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
            Rectangle {
                id: notContent
                anchors.fill: parent
                color: _colors.uTransparent
                visible: container.state === UEComparisonType.Not.toString()

                UI.UTimePicker {
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

                UI.UTimePicker {
                    id: notEndDatePicker
                    anchors.left: notAndLabel.right
                    anchors.leftMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
    /*

    Loader {
        property string tmpValue: getComparisonTypeValue()

        id: timeComparisonType

        anchors.left: timeConditionIcon.right
        anchors.verticalCenter: timeConditionIcon.verticalCenter

        sourceComponent: isEditMode ? timeConditionTypeDropdown : timeConditionTypeLabel

        function updateComparisonType() {
            updateComparisonTypeFunc()
        }
    }

    Component {
        id: timeConditionTypeLabel

        ULabel.Default {

            text: getComparisonTypeValue()

            Component.onCompleted: {
                updateComparisonTypeFunc = function() {
                    text = getComparisonTypeValue()
                    timeComparisonType.tmpValue = text
                }
            }
        }
    }

    Loader {
        property string tmpValue: Qt.formatTime(conditionModel.beginTime, "hh:mm")

        id: beginTime
        height: parent.height

        anchors.left: timeComparisonType.right
        anchors.verticalCenter: timeComparisonType.verticalCenter
        anchors.leftMargin: 5

        sourceComponent: isEditMode ? editableBeginTime : readonlyBeginTime

        function updateBeginTime() {
            updateBeginTimeFunc()
        }
    }

    Component {
        id: editableBeginTime

        UI.UTextbox {
            width: 100
            height: parent ? parent.height : 0

            text: Qt.formatTime(conditionModel.beginTime, "hh:mm")

            onTextChanged: {
                beginTime.tmpValue = text
            }
        }
    }

    Component {
        id: readonlyBeginTime

        Rectangle {
            width: 100
            height: parent ? parent.height : 0
            radius: 5
            color: _colors.uGreen

            ULabel.Heading3 {
                text: Qt.formatTime(conditionModel.beginTime, "hh:mm")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                color: _colors.uWhite

                Component.onCompleted: {
                    updateBeginTimeFunc = function() {
                        text = Qt.formatTime(conditionModel.beginTime, "hh:mm")
                    }
                }
            }
        }
    }

    ULabel.Default {

        id: conditionTimeToLabel

        anchors.left: beginTime.right
        anchors.leftMargin: 5
        anchors.verticalCenter: beginTime.verticalCenter

        text: getText()
        width: 15

        function updateText() {
            text = getText()
        }

        function getText() {
            if (timeComparisonType.tmpValue !== "From")
                return ""

            return "to"
        }
    }

    Loader {
        property string tmpValue: Qt.formatTime(conditionModel.endTime, "hh:mm")

        id: endTime

        anchors.left: conditionTimeToLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: beginTime.verticalCenter

        height: parent.height

        sourceComponent: getSourceComponent()

        function getSourceComponent() {
            if (timeComparisonType.tmpValue !== "From")
                return emptyEndTime

            if (isEditMode)
                return editableEndTime

            return readonlyEndTime
        }

        function updateEndTime() {
            updateEndTimeFunc()
        }
    }

    Component {
        id: editableEndTime

        UI.UTextbox {
            width: 100
            height: parent ? parent.height : 0

            text: Qt.formatTime(conditionModel.endTime, "hh:mm")

            onTextChanged: {
                endTime.tmpValue = text
            }
        }
    }

    Component {
        id: readonlyEndTime

        Rectangle {
            width: 100
            height: parent ? parent.height : 0
            radius: 5
            color: _colors.uGreen

            ULabel.Heading3 {
                text: Qt.formatTime(conditionModel.endTime, "hh:mm")
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter

                color: _colors.uWhite

                Component.onCompleted: {
                    updateEndTimeFunc = function() {
                        if (conditionModel)
                            text = Qt.formatTime(conditionModel.endTime, "hh:mm")
                    }
                }
            }
        }
    }

    Component {
        id: emptyEndTime

        Rectangle {
            width: 0
            height: 0
        }
    }

    */
}

