import QtQuick 2.0

import "../ui/UColors.js" as Colors
import "../ui" as UI
import "../label" as ULabel

import ConditionEnums 1.0

Rectangle {
    id: conditionEditorContainer

    property var conditionModel
    property int rowHeight: 38

    width: parent.width
    height: conditionTypeContainer.height + conditionCriterionContainer.height + separator.height
    color: Colors.uTransparent

    Rectangle
    {
        id: separator
        width: parent.width
        height: 2
        anchors.bottom: parent.bottom
        color: Colors.uGrey
    }

    Rectangle
    {
        id: content
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 5
        anchors.top: parent.top
        anchors.bottom: separator.top

        color: Colors.uTransparent

        Rectangle
        {
            id: conditionContainer

            anchors.left: parent.left
            anchors.right: deleteButtonContainer.left
            height: parent.height

            color: Colors.uTransparent

            Rectangle
            {
                id: conditionTypeContainer
                width: parent.width
                height: conditionEditorContainer.rowHeight
                color: Colors.uTransparent

                z: 2

                ULabel.ConditionLabel
                {
                    id: conditionTypeLabel
                    text: "CONDITION TYPE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    id: conditionTypeCombo
                    anchors.left: conditionTypeLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    UI.UCombobox
                    {
                        id: deviceTypeCombo
                        width: 200
                        height: 30
                        itemListModel: [
                                           { value:"Day", displayedValue:"Day", iconId:"Calendar"},
                                           { value:"Date", displayedValue:"Date", iconId:"Calendar"},
                                           { value:"Device", displayedValue:"Device", iconId:"lightning"},
                                           { value:"Time", displayedValue:"Time", iconId:"clock"}
                                       ]
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            Rectangle
            {
                id: conditionCriterionContainer

                width: parent.width
                height:  deviceTypeCombo.selectedItem !== null ? conditionSelector.height : 0
                anchors.top: conditionTypeContainer.bottom

                color: Colors.uTransparent

                z: 1

                Loader
                {
                    id: conditionSelector
                    sourceComponent: getSourceComponent()
                }
            }
        }

        Rectangle
        {
            id: deleteButtonContainer
            width: 40
            height: parent.height
            anchors.right: parent.right

            color: Colors.uTransparent

            UI.UButton
            {
                iconId: "Trash"
                width: parent.width
                height: parent.width

                buttonColor: Colors.uTransparent
                buttonHoveredColor: Colors.uTransparent
                buttonTextColor : Colors.uGrey
                buttonHoveredTextColor : Colors.uRed

                anchors.centerIn: parent
            }
        }
    }

    Component
    {
        id: emptyComponent

        Rectangle
        {
            height: 0
            color: "orange"
        }
    }

    Component
    {
        id: globalComponent

        Rectangle
        {
            id: globalContent
            width: conditionCriterionContainer.width
            height: operatorRow.height + conditionParameterContainer.height
            color: Colors.uTransparent

            Rectangle
            {
                id: operatorRow
                width: parent.width
                height: conditionEditorContainer.rowHeight

                color: Colors.uTransparent

                z: 2

                ULabel.ConditionLabel
                {
                    id: operatorLabel
                    text: "OPERATOR"
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

                    UI.UCombobox
                    {
                        id: operatorCombo
                        width: 200
                        height: 30
                        itemListModel: [
                                           { value:"lt", displayedValue:"Less than",    iconId:"" },
                                           { value:"gt", displayedValue:"Greater than", iconId:"" },
                                           { value:"e",  displayedValue:"Equal to",     iconId:"" },
                                           { value:"n",  displayedValue:"Not equal to", iconId:"" },
                                           { value:"b",  displayedValue:"Between",      iconId:"" }
                                       ]
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            Rectangle
            {
                id: conditionParameterContainer
                width: parent.width
                height:  operatorCombo.selectedItem !== null ? conditionParameterSelector.height : 0
                anchors.top: operatorRow.bottom

                color: Colors.uTransparent

                z: 1

                Loader
                {
                    id: conditionParameterSelector
                    sourceComponent: getParameterComponent(operatorCombo.selectedItem)
                }
            }
        }
    }

    Component
    {
        id: dayGlobalComponent

        Rectangle
        {
            id: globalContent
            width: conditionCriterionContainer.width
            height: conditionEditorContainer.rowHeight
            color: Colors.uTransparent

            ULabel.ConditionLabel
            {
                id: valueLabel
                text: "VALUE"
                width: 150
                anchors.verticalCenter: parent.verticalCenter

                font.italic: true
                font.pointSize: 10
            }

            Rectangle
            {
                anchors.left: valueLabel.right
                anchors.right: parent.right
                height: parent.height

                color: Colors.uTransparent

                Loader
                {
                    id: parameterSelector
                    sourceComponent: getSelectorComponent()
                }
            }
        }
    }

    Component
    {
        id: deviceGlobalComponent

        Rectangle
        {
            id: globalContent
            width: conditionCriterionContainer.width
            height: deviceRow.height + operatorRow.height + conditionParameterContainer.height
            color: Colors.uTransparent

            Rectangle
            {
                id: deviceRow
                width: parent.width
                height: conditionEditorContainer.rowHeight

                color: Colors.uTransparent

                z: 3

                ULabel.ConditionLabel
                {
                    id: deviceLabel
                    text: "DEVICE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    anchors.left: deviceLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    UI.UCombobox
                    {
                        id: deviceCombo
                        width: 200
                        height: 30
                        itemListModel: [
                                           { value:"100", displayedValue:"Device with id=100", iconId:"" }
                                       ]
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            Rectangle
            {
                id: operatorRow
                width: parent.width
                height: conditionEditorContainer.rowHeight
                anchors.top: deviceRow.bottom

                color: Colors.uTransparent

                z: 2

                ULabel.ConditionLabel
                {
                    id: operatorLabel
                    text: "OPERATOR"
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

                    UI.UCombobox
                    {
                        id: operatorCombo
                        width: 200
                        height: 30
                        itemListModel: [
                                           { value:"lt", displayedValue:"Less than",    iconId:"" },
                                           { value:"gt", displayedValue:"Greater than", iconId:"" },
                                           { value:"e",  displayedValue:"Equal to",     iconId:"" },
                                           { value:"n",  displayedValue:"Not equal to", iconId:"" },
                                           { value:"b",  displayedValue:"Between",      iconId:"" }
                                       ]
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }

            Rectangle
            {
                id: conditionParameterContainer
                width: parent.width
                height:  operatorCombo.selectedItem !== null ? conditionParameterSelector.height : 0
                anchors.top: operatorRow.bottom

                color: Colors.uTransparent

                z: 1

                Loader
                {
                    id: conditionParameterSelector
                    sourceComponent: getParameterComponent(operatorCombo.selectedItem)
                }
            }
        }
    }

    Component
    {
        id: lessThanComponent

        Rectangle
        {
            width: conditionCriterionContainer.width
            height: conditionEditorContainer.rowHeight * 1

            color: Colors.uTransparent

            Rectangle
            {
                id: valueRow
                width: parent.width
                height: conditionEditorContainer.rowHeight

                color: Colors.uTransparent

                ULabel.ConditionLabel
                {
                    id: valueLabel
                    text: "VALUE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    anchors.left: valueLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    Loader
                    {
                        id: parameterSelector
                        sourceComponent: getSelectorComponent()
                    }
                }
            }
        }
    }

    Component
    {
        id: greaterThanComponent

        Rectangle
        {
            width: conditionCriterionContainer.width
            height: conditionEditorContainer.rowHeight * 1

            color: Colors.uTransparent

            Rectangle
            {
                id: valueRow
                width: parent.width
                height: conditionEditorContainer.rowHeight

                color: Colors.uTransparent

                ULabel.ConditionLabel
                {
                    id: valueLabel
                    text: "VALUE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    anchors.left: valueLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    Loader
                    {
                        id: parameterSelector
                        sourceComponent: getSelectorComponent()
                    }
                }
            }
        }
    }

    Component
    {
        id: equalComponent

        Rectangle
        {
            width: conditionCriterionContainer.width
            height: conditionEditorContainer.rowHeight * 1

            color: Colors.uTransparent

            Rectangle
            {
                id: valueRow
                width: parent.width
                height: conditionEditorContainer.rowHeight

                color: Colors.uTransparent

                ULabel.ConditionLabel
                {
                    id: valueLabel
                    text: "VALUE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    anchors.left: valueLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    Loader
                    {
                        id: parameterSelector
                        sourceComponent: getSelectorComponent()
                    }
                }
            }
        }
    }

    Component
    {
        id: notComponent

        Rectangle
        {
            width: conditionCriterionContainer.width
            height: conditionEditorContainer.rowHeight * 1

            color: Colors.uTransparent

            Rectangle
            {
                id: valueRow
                width: parent.width
                height: conditionEditorContainer.rowHeight

                color: Colors.uTransparent

                ULabel.ConditionLabel
                {
                    id: valueLabel
                    text: "VALUE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    anchors.left: valueLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    Loader
                    {
                        id: parameterSelector
                        sourceComponent: getSelectorComponent()
                    }
                }
            }
        }
    }

    Component
    {
        id: betweenComponent

        Rectangle
        {
            width: conditionCriterionContainer.width
            height: conditionEditorContainer.rowHeight * 2

            color: Colors.uTransparent

            Rectangle
            {
                id: beginValueRow
                width: parent.width
                height: conditionEditorContainer.rowHeight

                color: Colors.uTransparent

                z: 2

                ULabel.ConditionLabel
                {
                    id: beginValueLabel
                    text: "BEGIN VALUE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    anchors.left: beginValueLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    Loader
                    {
                        sourceComponent: getSelectorComponent()
                    }
                }
            }

            Rectangle
            {
                id: endValueRow
                width: parent.width
                height: conditionEditorContainer.rowHeight
                anchors.top: beginValueRow.bottom
                color: Colors.uTransparent

                z: 1

                ULabel.ConditionLabel
                {
                    id: endValueLabel
                    text: "END VALUE"
                    width: 150
                    anchors.verticalCenter: parent.verticalCenter

                    font.italic: true
                    font.pointSize: 10
                }

                Rectangle
                {
                    anchors.left: endValueLabel.right
                    anchors.right: parent.right
                    height: parent.height

                    color: Colors.uTransparent

                    Loader
                    {
                        sourceComponent: getSelectorComponent()
                    }
                }
            }
        }
    }

    Component
    {
        id: dateSelectorComponent

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UDatePicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Component
    {
        id: daySelectorComponent

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UWeekdayPicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Component
    {
        id: timeSelectorComponent

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UTimePicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }

    Component
    {
        id: deviceSelectorComponent

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UTextbox
            {
                width: 300
                height: 30

                placeholderText: "Enter a device value"

                function validate()
                {
                    return text !== ""
                }

                state: validate() ? "SUCCESS" : "ERROR"
            }
        }
    }

    function getSelectorComponent()
    {
        if(deviceTypeCombo.selectedItem === null)
            return emptyComponent

        switch(deviceTypeCombo.selectedItem.value)
        {
            case "Date":
                return dateSelectorComponent
            case "Day":
                return daySelectorComponent
            case "Time":
                return timeSelectorComponent
            case "Device":
                return deviceSelectorComponent
        }
    }

    function getSourceComponent()
    {
        if(deviceTypeCombo.selectedItem === null)
            return emptyComponent

        switch(deviceTypeCombo.selectedItem.value)
        {
            case "Date":
            case "Time":
                return globalComponent
            case "Day":
                return dayGlobalComponent
            case "Device":
                return deviceGlobalComponent
        }
    }

    function getParameterComponent(selectedOperator)
    {
        if(selectedOperator === null)
            return emptyComponent

        switch(selectedOperator.value)
        {
            case "lt":
                return lessThanComponent
            case "gt":
                return greaterThanComponent
            case "e":
                return equalComponent
            case "n":
                return notComponent
            case "b":
                return betweenComponent
        }
    }
}
