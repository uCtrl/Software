import QtQuick 2.0

import "../../label" as ULabel
import "../../ui" as UI
import "../../ui/UColors.js" as Colors

import DeviceEnums 1.0 as DeviceEnums
import ConditionEnums 1.0

DefaultRow {
    id: beginValueRowContentContainer

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
                setValue(conditionEditorContainer.getCondition().beginValue())
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().beginValue(getValue())
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
                if(getCondition().beginValue() !== "")
                {
                    selectedDate = new Date(parseInt(conditionEditorContainer.getCondition().beginValue()))
                }
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().beginValue(selectedDate.getTime())
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
                state = conditionEditorContainer.getCondition().beginValue() === "1" ? "ON" : "OFF"
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().beginValue(state === "ON" ? 1 : 0)
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
            property int textWidth: 50
            x: textWidth
            width: 200 - textWidth

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
                    value = conditionEditorContainer.getCondition().beginValue() * 100
                }

                function saveValue()
                {
                    if(expanded)
                    {
                        conditionEditorContainer.getCondition().beginValue(value / 100)
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
                text = conditionEditorContainer.getCondition().beginValue()
            }

            function saveValue()
            {
                if(expanded)
                {
                    conditionEditorContainer.getCondition().beginValue(text)
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
                    conditionEditorContainer.getCondition().beginValue(1)
                    conditionEditorContainer.getCondition().comparisonType(UEType.None)
                }
            }
        }
    }

    function getSourceComponent()
    {
        console.log("Source component: " + valuePickerType)
        switch(valuePickerType)
        {
            case DeviceEnums.UEValueType.Time:
                return timeComponent
            case DeviceEnums.UEValueType.Date:
                return dateComponent
            case DeviceEnums.UEValueType.Switch:
                return switchComponent
            case DeviceEnums.UEValueType.Slider:
                return sliderComponent
            case DeviceEnums.UEValueType.Textbox:
                return textboxComponent
            case DeviceEnums.UEValueType.Event:
                return eventComponent
        }
    }
}
