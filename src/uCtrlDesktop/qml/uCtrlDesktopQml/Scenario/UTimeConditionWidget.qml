import QtQuick 2.0
import ConditionEnums 1.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle{

    property var timeCondition: null
    property real conditionHour : 12
    property real conditionMinute : 15

    id: container

    width: parent.width - 30
    height: parent.height - 5

    anchors.left: parent.left
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    color: _colors.uTransparent

    function saveCondition() {
        setComparisonTypeValue(timeConditionType.tmpValue)

        console.log(beginTime.tmpValue)
        console.log(endTime.tmpValue)
        conditionModel.beginTime = beginTime.tmpValue
        conditionModel.endTime = endTime.tmpValue
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
            console.log("WRONG TIME CONDITION TYPE")
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

        id: timeConditionType

        anchors.left: timeConditionIcon.right
        anchors.verticalCenter: timeConditionIcon.verticalCenter

        sourceComponent: isEditMode ? timeConditionTypeDropdown : timeConditionTypeLabel
    }

    Component {
        id: timeConditionTypeDropdown

        UI.UComboBox {
            width: 100

            itemListModel: [
                { value:"From", displayedValue:"From", iconId:""},
                { value:"Before", displayedValue:"Before", iconId:""},
                { value:"After", displayedValue:"After", iconId:""}
            ]

            onSelectValue: {
                timeConditionType.tmpValue = selectedItem.value
            }
        }
    }

    Component {
        id: timeConditionTypeLabel

        ULabel.Default {
            width: 100

            text: getComparisonTypeValue()
        }
    }

    Loader {
        property string tmpValue: Qt.formatTime(conditionModel.beginTime, "hh:mm")

        id: beginTime
        height: parent.height

        anchors.left: timeConditionType.right
        anchors.verticalCenter: timeConditionType.verticalCenter
        anchors.leftMargin: 5

        sourceComponent: isEditMode ? editableBeginTime : readonlyBeginTime
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
            }
        }
    }

    ULabel.Default {

        id: conditionTimeToLabel

        anchors.left: beginTime.right
        anchors.leftMargin: 5
        anchors.verticalCenter: beginTime.verticalCenter

        text: getText()
        width: 50

        function getText() {
            switch (conditionModel.comparisonType) {
            case UEComparisonType.InBetween:
                return "to"
            default:
                return ""
            }
        }
    }

    Loader {
        property string tmpValue: conditionModel.endTime

        id: endTime

        anchors.left: conditionTimeToLabel.right
        anchors.leftMargin: 5
        anchors.verticalCenter: beginTime.verticalCenter

        height: parent.height

        sourceComponent: getSourceComponent()

        function getSourceComponent() {
            console.log(conditionModel.comparisonType)
            if (conditionModel.comparisonType !== UEComparisonType.InBetween)
                return emptyEndTime

            if (isEditMode)
                return editableEndTime

            return readonlyEndTime
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

