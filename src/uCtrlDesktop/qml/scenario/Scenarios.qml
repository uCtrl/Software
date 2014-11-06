import QtQuick 2.0

import "../label" as ULabel
import "../ui/UColors.js" as Colors
import "../ui/" as UI

Rectangle {

    id: scenarios

    property var model: null
    property var scenariosList: []

    Rectangle {
       id: noScenario

       visible: (model !== null && model !== undefined && !(model.rowCount() > 0))

       color: Colors.uTransparent

       anchors.fill: parent

       ULabel.Default {
           anchors.centerIn: parent

           text: "No scenarios available"
           font.bold: true
           font.pointSize: 32

           color: Colors.uGrey
       }
    }

    Rectangle {
        id: scenarioContainer
        anchors.fill: parent

        visible: (model !== null && model !== undefined && model.rowCount() > 0)

        color: Colors.uTransparent

        UI.UCombobox {
            id: scenarioCombo

            itemListModel: scenariosList

            anchors.left: parent.left
            anchors.top: parent.top

            height: 35; width: parent.width

            Component.onCompleted: {
                selectItem(0)
                currentScenario.model = scenarios.model.get(selectedItem)
            }

            z: 3

            onSelectedItemChanged: if (scenarios.model !== null && scenarios.model !== undefined) currentScenario.model = scenarios.model.get(selectedItem)
        }

        z: 2
    }

    onModelChanged: {
        currentScenario.model = null;
        scenarioCombo.selectedItem = null
        if (model !== null && model !== undefined) {
            scenariosList = null;
            if (model.rowCount() > 0) {
                for (var i=0;i<model.rowCount();i++) {
                    var item = {value: i, displayedValue: model.get(i).name, iconId: ""};
                    if (scenariosList != null) scenariosList.push(item);
                    else scenariosList = [item];
                }
            }
        }
    }

    Scenario {
        id: currentScenario

        anchors.left: scenarios.left
        anchors.right: scenarios.right
        anchors.top: scenarios.top
        anchors.bottom: scenarios.bottom

        visible: (currentScenario.model != null)
    }
}
