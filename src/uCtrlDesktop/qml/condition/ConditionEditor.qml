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
                    source: "qrc:/qml/condition/type/%1.qml".arg(getSourceComponent())
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

    function getDeviceList()
    {
        var deviceComboList = [];

        for(var i = 0; i < devicesList.rowCount; i++)
        {
            var device = devicesList.getRow(i);
            deviceComboList[i] = { value: device.id(), displayedValue:device.name(), iconId:"" }
        }

        return deviceComboList
    }

    function getSourceComponent()
    {
        if(deviceTypeCombo.selectedItem === null)
            return "EmptyCondition"

        switch(deviceTypeCombo.selectedItem.value)
        {
            case UEType.Date:
                return "DateCondition"
            case UEType.Time:
                return "TimeCondition"
            case UEType.Day:
                return "DayCondition"
            case UEType.Device:
                return "DeviceCondition"
        }
    }

    function saveForm()
    {
        if(typeof(getCondition) != "undefined")
        {
            var condition = getCondition();
            if(deviceTypeCombo.selectedItem !== null)
            {
                condition.type(deviceTypeCombo.selectedItem.value)
            }

            saveConditionDetails()

            uCtrlApiFacade.putCondition(condition)
        }
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
