import QtQuick 2.0

import "../../label" as ULabel
import "../../ui" as UI
import "../../ui/UColors.js" as Colors

DefaultRow {

    ULabel.ConditionLabel
    {
        id: operatorLabel
        text: "VALUE"
        width: 150
        anchors.verticalCenter: parent.verticalCenter

        font.italic: true
        font.pointSize: 10
    }

    Rectangle
    {
        anchors.left: operatorLabel.right
        anchors.right: parent.right
        height: parent.height

        color: Colors.uTransparent

        UI.UWeekdayPicker
        {
            id: weekDayPicker
            anchors.verticalCenter: parent.verticalCenter

        }
    }

    Component.onCompleted: {
        conditionEditorContainer.saveConditionDetails.connect(saveValue)

        conditionModelChanged()
    }

    function conditionModelChanged()
    {
        weekDayPicker.setValue(conditionEditorContainer.getCondition().beginValue())
    }

    function saveValue()
    {
        conditionEditorContainer.getCondition().beginValue(weekDayPicker.getValue())
    }
}
