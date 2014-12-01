import QtQuick 2.0

import "../../label" as ULabel
import "../../ui" as UI
import "../../ui/UColors.js" as Colors

import ConditionEnums 1.0

DefaultRow {

    property var deviceSelected: deviceCombo.selectedItem !== null ? deviceCombo.selectedItem.value : null

    ULabel.ConditionLabel
    {
        id: operatorLabel
        text: "DEVICE"
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
            id: deviceCombo
            width: 300
            height: 30
            itemListModel: conditionEditorContainer.getDeviceList()
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Component.onCompleted: {
        conditionEditorContainer.saveConditionDetails.connect(saveValue)

        conditionModelChanged()
    }

    function conditionModelChanged()
    {
        deviceCombo.selectItemByValue(conditionEditorContainer.getCondition().deviceId())
    }

    function saveValue()
    {
        conditionEditorContainer.getCondition().deviceId(deviceCombo.selectedItem.value)
    }
}
