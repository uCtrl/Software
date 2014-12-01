import QtQuick 2.0

import "../row" as UConditionRow

import ConditionEnums 1.0 as ConditionEnum
import DeviceEnums 1.0 as DeviceEnum

DefaultCondition
{
    id: dayConditionContentContainer

    height: content.height

    Column
    {
        id: content
        width: parent.width
        height: deviceRow.height + dynamicSelection.height + operatorRow.height + beginValueRow.height + endValueRow.height

        property int editionType: getDeviceEditionType(deviceRow.deviceSelected)

        UConditionRow.DeviceSelectionRow
        {
            id: deviceRow
            width: parent.width

            z: 4
        }

        UConditionRow.BeginValueRow
        {
            id: dynamicSelection
            width: parent.width
            valuePickerType: content.editionType

            expanded: (content.editionType === DeviceEnum.UEValueType.Event) || (content.editionType === DeviceEnum.UEValueType.Switch)

            z: 3
        }

        UConditionRow.OperatorRow
        {
            id: operatorRow
            width: parent.width

            expanded: !dynamicSelection.expanded && deviceRow.deviceSelected !== null

            z: 2
        }

        UConditionRow.BeginValueRow
        {
            id: beginValueRow
            width: parent.width
            valuePickerType: content.editionType

            expanded: operatorRow.expanded && operatorRow.operatorSelected !== null &&
                      (operatorRow.operatorSelected === ConditionEnum.UEComparisonType.GreaterThan ||
                       operatorRow.operatorSelected === ConditionEnum.UEComparisonType.Equals ||
                       operatorRow.operatorSelected === ConditionEnum.UEComparisonType.Not ||
                       operatorRow.operatorSelected === ConditionEnum.UEComparisonType.InBetween)

            z: 1
        }

        UConditionRow.EndValueRow
        {
            id: endValueRow
            width: parent.width
            valuePickerType: content.editionType

            expanded: operatorRow.expanded && operatorRow.operatorSelected !== null &&
                      (operatorRow.operatorSelected === ConditionEnum.UEComparisonType.LesserThan ||
                       operatorRow.operatorSelected === ConditionEnum.UEComparisonType.InBetween)
        }
    }

    function getDeviceEditionType(deviceId)
    {
        if(deviceId === null)
            return DeviceEnum.UEValueType.Textbox

        var device = devicesList.findObject(deviceId)

        return device.valueType()
    }
}
