import QtQuick 2.0

import "../row" as UConditionRow

DefaultCondition
{
    id: dayConditionContentContainer

    height: content.height

    Column
    {
        id: content
        width: parent.width
        height: beginValueRow.height

        UConditionRow.DaySelectionRow
        {
            id: beginValueRow
            width: parent.width
        }
    }
}
