import QtQuick 2.0
import ConditionEnums 1.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle{

    property var timeCondition: null

    property var updateBeginTimeFunc: function(){}
    property var updateEndTimeFunc: function(){}
    property var updateComparisonTypeFunc: function(){}

    id: container

    width: parent.width - 30
    height: parent.height - 5

    anchors.left: parent.left
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    color: _colors.uTransparent

    function saveCondition() {
        setComparisonTypeValue(timeComparisonType.tmpValue)

        conditionModel.beginTime = beginTime.tmpValue
        conditionModel.endTime = endTime.tmpValue

        updateConditionView()
    }

    function updateConditionView() {
        timeComparisonType.updateComparisonType()
        beginTime.updateBeginTime()
        endTime.updateEndTime()
        conditionTimeToLabel.updateText()
    }

    function getComparisonTypeValue() {
        switch (conditionModel.comparisonType) {
        case UEComparisonType.GreaterThan:
            return "After"
        case UEComparisonType.LesserThan:
            return "Before"
        case UEComparisonType.InBetween:
            return "From"
        default:
            return ""
        }
    }

    function setComparisonTypeValue(typeValue) {
        switch (typeValue) {
        case "After":
            conditionModel.comparisonType = UEComparisonType.GreaterThan
            break;
        case "Before":
            conditionModel.comparisonType = UEComparisonType.LesserThan
            break;
        case "From":
            conditionModel.comparisonType = UEComparisonType.InBetween
            break;
        default:
            break;
        }
    }

    UI.UFontAwesome {
        id: timeConditionIcon

        width: parent.height
        height: parent.height

        iconId: "Time"
        iconSize: 16
        iconColor: _colors.uBlack
        anchors.left: parent.left
    }

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
        id: timeConditionTypeDropdown

        UI.UComboBox {
            width: 100
            height: 30

            itemListModel: [
                { value:"From", displayedValue:"From", iconId:""},
                { value:"Before", displayedValue:"Before", iconId:""},
                { value:"After", displayedValue:"After", iconId:""}
            ]

            onSelectValue: {
                timeComparisonType.tmpValue = selectedItem.value
                conditionTimeToLabel.updateText()
            }

            Component.onCompleted: {
                var comparisonTypeValue = getComparisonTypeValue()
                for (var i = 0; i < itemListModel.length; i++) {
                    if (itemListModel[i].value === comparisonTypeValue) {
                        selectItem(i)
                    }
                }
            }
        }
    }

    Component {
        id: timeConditionTypeLabel

        ULabel.Default {
            width: 100

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
}

