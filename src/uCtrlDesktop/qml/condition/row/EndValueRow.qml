import QtQuick 2.0

import "../../label" as ULabel
import "../../ui" as UI
import "../../ui/UColors.js" as Colors

import DeviceEnums 1.0 as DeviceEnums
import ConditionEnums 1.0

DefaultRow {
    id: endValueRowContentContainer

    property int valuePickerType: DeviceEnums.UEValueType.Textbox

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

        Loader
        {
            anchors.verticalCenter: parent.verticalCenter
            sourceComponent: getSourceComponent()
        }
    }

    Component
    {
        id: timeComponent

        UI.UTimePicker
        {
            height: 30

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveValue)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                setValue(conditionEditorContainer.getCondition().endValue())
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().endValue(getValue())
                }
            }
        }
    }

    Component
    {
        id: dateComponent

        UI.UDatePicker
        {
            height: 30

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveValue)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                if(getCondition().endValue() !== "")
                {
                    selectedDate = new Date(parseInt(conditionEditorContainer.getCondition().endValue()))
                }
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().endValue(selectedDate.getTime())
                }
            }
        }
    }

    Component
    {
        id: colorComponent

        UI.UCompactColorPicker
        {
            width: 130
            height: 30

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveValue)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                hsbFromRgb("#" + conditionEditorContainer.getCondition().endValue())
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().endValue(pickerString)
                    conditionEditorContainer.getCondition().comparisonType(UEComparisonType.None)
                }
            }
        }
    }

    Component
    {
        id: switchComponent

        UI.USwitch
        {
            width: 100
            height: 30

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveValue)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                state = conditionEditorContainer.getCondition().endValue() === "1" ? "ON" : "OFF"
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().endValue(state === "ON" ? 1 : 0)
                    conditionEditorContainer.getCondition().comparisonType(UEComparisonType.None)
                }
            }
        }
    }

    Component
    {
        id: upDownSwitchComponent

        UI.USwitch
        {
            width: 100
            height: 30

            onValueLabel: "UP"
            offValueLabel: "DOWN"

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveValue)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                state = conditionEditorContainer.getCondition().endValue() === "1" ? "ON" : "OFF"
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().endValue(state === "ON" ? 1 : 0)
                    conditionEditorContainer.getCondition().comparisonType(UEComparisonType.None)
                }
            }
        }
    }

    Component
    {
        id: sliderComponent

        Rectangle
        {
            property int textWidth: 60
            x: textWidth
            width: 200 - textWidth
            height: parent.height

            color: Colors.uTransparent

            UI.USlider
            {
                width: parent.width
                height: 30

                minimumValue: 0
                maximumValue: 100
                stepSize: 1

                textWidth: parent.textWidth
                textSize: 16


                Component.onCompleted: {
                    conditionEditorContainer.saveConditionDetails.connect(saveValue)
                    conditionModelChanged()
                }

                function conditionModelChanged()
                {
                    value = conditionEditorContainer.getCondition().endValue() * 100
                }

                function saveValue()
                {
                    if(expanded)
                    {
                        conditionEditorContainer.getCondition().endValue(value / 100)
                    }
                }
            }
        }
    }

    Component
    {
        id: textboxComponent

        UI.UTextbox
        {
            width: 150
            height: 30

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveValue)
                conditionModelChanged()
            }

            function validate()
            {
                return text !== ""
            }

            state: validate() ? "SUCCESS" : "ERROR"

            function conditionModelChanged()
            {
                text = conditionEditorContainer.getCondition().endValue()
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().endValue(text)
                }
            }
        }
    }

    Component
    {
        id: eventComponent

        ULabel.ConditionLabel
        {
            id: eventLabel
            text: "When the device fires an event"

            height: 30

            font.italic: true
            font.pointSize: 10

            verticalAlignment: Text.AlignVCenter

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveValue)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().endValue(1)
                    conditionEditorContainer.getCondition().comparisonType(UEType.None)
                }
            }
        }
    }

    function getSourceComponent()
    {
        switch(valuePickerType)
        {
            case DeviceEnums.UEValueType.Time:
                return timeComponent
            case DeviceEnums.UEValueType.Date:
                return dateComponent
            case DeviceEnums.UEValueType.Switch:
                return switchComponent
            case DeviceEnums.UEValueType.UpDownSwitch:
                return upDownSwitchComponent
            case DeviceEnums.UEValueType.Color:
                return colorComponent
            case DeviceEnums.UEValueType.Slider:
                return sliderComponent
            case DeviceEnums.UEValueType.Textbox:
                return textboxComponent
            case DeviceEnums.UEValueType.Event:
                return eventComponent
        }
    }
}
