import QtQuick 2.0

import "../row" as UConditionRow

import DeviceEnums 1.0 as DeviceEnums
import ConditionEnums 1.0

DefaultCondition
{
    id: dayConditionContentContainer
    height: content.height

    Column
    {
        id: content
        width: parent.width
        height: operatorRow.height + beginValueRow.height + endValueRow.height

        UConditionRow.OperatorRow
        {
            id: operatorRow
            width: parent.width

            z: 3
        }
        UConditionRow.BeginValueRow
        {
            id: beginValueRow
            width: parent.width
            valuePickerType: DeviceEnums.UEValueType.Date

            expanded: operatorRow.operatorSelected !== null &&
                      (operatorRow.operatorSelected === UEComparisonType.GreaterThan ||
                       operatorRow.operatorSelected === UEComparisonType.Equals ||
                       operatorRow.operatorSelected === UEComparisonType.Not ||
                       operatorRow.operatorSelected === UEComparisonType.LesserThan ||
                       operatorRow.operatorSelected === UEComparisonType.InBetween)

            z: 2
        }
        UConditionRow.EndValueRow
        {
            id: endValueRow
            width: parent.width
            valuePickerType: DeviceEnums.UEValueType.Date

            expanded: operatorRow.operatorSelected !== null &&
                      (operatorRow.operatorSelected === UEComparisonType.InBetween)

            z: 1
        }
    }
}
