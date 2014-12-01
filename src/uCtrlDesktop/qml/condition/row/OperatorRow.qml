import QtQuick 2.0

import "../../label" as ULabel
import "../../ui" as UI
import "../../ui/UColors.js" as Colors

import ConditionEnums 1.0

DefaultRow {

    property var operatorSelected: operatorCombo.selectedItem !== null ? operatorCombo.selectedItem.value : null

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

    Component.onCompleted: {
        conditionEditorContainer.saveConditionDetails.connect(saveValue)

        conditionModelChanged()
    }

    function conditionModelChanged()
    {
        operatorCombo.selectItemByValue(conditionEditorContainer.getCondition().comparisonType())
    }

    function saveValue()
    {
        if(expanded)
            conditionEditorContainer.getCondition().comparisonType(operatorCombo.selectedItem.value)
    }
}
