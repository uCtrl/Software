import QtQuick 2.0

import "../ui/UColors.js" as Colors
import "../ui" as UI
import "../label" as ULabel

import ConditionEnums 1.0

Rectangle {
    id: conditionEditorContainer

    property var conditionModel
    property int rowHeight: 38

    signal saveConditionDetails()

    width: parent.width
    height: conditionTypeContainer.height + conditionCriterionContainer.height + separator.height
    color: Colors.uTransparent

    onConditionModelChanged:
    {
        console.log("CONDITION MODEL UPDATE")
        if(getCondition().type() !== UEType.None)
        {
            deviceTypeCombo.selectItemByValue(getCondition().type())
        }
    }

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
                                           { value:UEType.Day,    displayedValue:"Day",    iconId:"Calendar"},
                                           { value:UEType.Date,   displayedValue:"Date",   iconId:"Calendar"},
                                           { value:UEType.Device, displayedValue:"Device", iconId:"lightning"},
                                           { value:UEType.Time,   displayedValue:"Time",   iconId:"clock"}
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

                onClicked: deleteCondition()
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
                                           { value:UEComparisonType.LesserThan,  displayedValue:"Less than",    iconId:"" },
                                           { value:UEComparisonType.GreaterThan, displayedValue:"Greater than", iconId:"" },
                                           { value:UEComparisonType.Equals,      displayedValue:"Equal to",     iconId:"" },
                                           { value:UEComparisonType.Not,         displayedValue:"Not equal to", iconId:"" },
                                           { value:UEComparisonType.InBetween,   displayedValue:"Between",      iconId:"" }
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

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)

                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                operatorCombo.selectItemByValue(getCondition().comparisonType())
            }

            function saveOperator()
            {
                if(operatorCombo.selectedItem !== null)
                {
                    getCondition().comparisonType(operatorCombo.selectedItem.value)
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
                        width: 300
                        height: 30
                        itemListModel: getDeviceList()
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
                                           { value:UEComparisonType.LesserThan,  displayedValue:"Less than",    iconId:"" },
                                           { value:UEComparisonType.GreaterThan, displayedValue:"Greater than", iconId:"" },
                                           { value:UEComparisonType.Equals,      displayedValue:"Equal to",     iconId:"" },
                                           { value:UEComparisonType.Not,         displayedValue:"Not equal to", iconId:"" },
                                           { value:UEComparisonType.InBetween,   displayedValue:"Between",      iconId:"" }
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

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                deviceCombo.selectItemByValue(getCondition().deviceId())
                operatorCombo.selectItemByValue(getCondition().comparisonType())
            }

            function saveOperator()
            {
                if(deviceCombo.selectedItem !== null)
                {
                    getCondition().deviceId(deviceCombo.selectedItem.value)
                }
                if(operatorCombo.selectedItem !== null)
                {
                    getCondition().comparisonType(operatorCombo.selectedItem.value)
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
                        sourceComponent: getSelectorComponent("endCondition")
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
                        sourceComponent: getSelectorComponent("beginCondition")
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
                        sourceComponent: getSelectorComponent("beginCondition")
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
                        sourceComponent: getSelectorComponent("beginCondition")
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
                        sourceComponent: getSelectorComponent("beginCondition")
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
                        sourceComponent: getSelectorComponent("endCondition")
                    }
                }
            }
        }
    }

    Component
    {
        id: dateSelectorComponentBegin

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UDatePicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
            }

            function saveOperator()
            {

            }
        }
    }
    Component
    {
        id: dateSelectorComponentEnd

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UDatePicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
            }

            function saveOperator()
            {

            }
        }
    }

    Component
    {
        id: daySelectorComponentBegin

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UWeekdayPicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
            }

            function saveOperator()
            {

            }
        }
    }
    Component
    {
        id: daySelectorComponentEnd

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UWeekdayPicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
            }

            function saveOperator()
            {

            }
        }
    }

    Component
    {
        id: timeSelectorComponentBegin

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UTimePicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
            }

            function saveOperator()
            {

            }
        }
    }
    Component
    {
        id: timeSelectorComponentEnd

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UTimePicker
            {
                anchors.verticalCenter: parent.verticalCenter
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
            }

            function saveOperator()
            {

            }
        }
    }

    Component
    {
        id: deviceSelectorComponentBegin

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UTextbox
            {
                id: deviceTextbox
                width: 300
                height: 30

                placeholderText: "Enter a device value"

                function validate()
                {
                    return text !== ""
                }

                state: validate() ? "SUCCESS" : "ERROR"
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                deviceTextbox.text = getCondition().beginValue()
            }

            function saveOperator()
            {
                if(deviceTextbox.validate())
                {
                    getCondition().beginValue(deviceTextbox.text)
                }
            }
        }
    }
    Component
    {
        id: deviceSelectorComponentEnd

        Rectangle
        {
            width: conditionTypeCombo.width
            height: conditionEditorContainer.rowHeight

            color: Colors.uTransparent

            UI.UTextbox
            {
                id: deviceTextbox

                width: 300
                height: 30

                placeholderText: "Enter a device value"

                function validate()
                {
                    return text !== ""
                }

                state: validate() ? "SUCCESS" : "ERROR"
            }

            Component.onCompleted: {
                conditionEditorContainer.saveConditionDetails.connect(saveOperator)
                conditionModelChanged()
            }

            function conditionModelChanged()
            {
                deviceTextbox.text = getCondition().endValue()
            }

            function saveOperator()
            {
                if(deviceTextbox.validate())
                {
                    getCondition().endValue(deviceTextbox.text)
                }
            }
        }
    }

    function getDeviceList()
    {
        var deviceComboList = [];

        for(var i = 0; i < devicesList.rowCount(); i++)
        {
            var device = devicesList.getRow(i);
            deviceComboList[i] = { value: device.id(), displayedValue:device.name(), iconId:"" }
        }

        return deviceComboList
    }

    function getSelectorComponent(valueType)
    {
        if(deviceTypeCombo.selectedItem === null)
            return emptyComponent

        switch(deviceTypeCombo.selectedItem.value)
        {
            case UEType.Date:
                return valueType === "beginCondition" ? dateSelectorComponentBegin : dateSelectorComponentEnd
            case UEType.Day:
                return valueType === "beginCondition" ? daySelectorComponentBegin : daySelectorComponentEnd
            case UEType.Time:
                return valueType === "beginCondition" ? timeSelectorComponentBegin : timeSelectorComponentEnd
            case UEType.Device:
                return valueType === "beginCondition" ? deviceSelectorComponentBegin : deviceSelectorComponentEnd
        }
    }

    function getSourceComponent()
    {
        if(deviceTypeCombo.selectedItem === null)
            return emptyComponent

        switch(deviceTypeCombo.selectedItem.value)
        {
            case UEType.Date:
            case UEType.Time:
                return globalComponent
            case UEType.Day:
                return dayGlobalComponent
            case UEType.Device:
                return deviceGlobalComponent
        }
    }

    function getParameterComponent(selectedOperator)
    {
        if(selectedOperator === null)
            return emptyComponent

        switch(selectedOperator.value)
        {
            case UEComparisonType.LesserThan:
                return lessThanComponent
            case UEComparisonType.GreaterThan:
                return greaterThanComponent
            case UEComparisonType.Equals:
                return equalComponent
            case UEComparisonType.Not:
                return notComponent
            case UEComparisonType.InBetween:
                return betweenComponent
        }
    }

    function saveForm()
    {
        var condition = getCondition();
        if(deviceTypeCombo.selectedItem !== null)
        {
            condition.type(deviceTypeCombo.selectedItem.value)
        }

        saveConditionDetails()

        uCtrlApiFacade.putCondition(condition)
    }

    function getCondition()
    {
        return taskEditorContainer.conditionModel.findObject(conditionModel.id)
    }

    function deleteCondition()
    {
        uCtrlApiFacade.deleteCondition(getCondition())
        taskEditorContainer.conditionModel.removeRow(getCondition().id())

        taskEditorContainer.refreshConditionCountLabel()
    }
}
