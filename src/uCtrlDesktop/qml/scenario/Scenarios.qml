import QtQuick 2.0

import "../label" as ULabel
import "../ui/UColors.js" as Colors
import "../ui/" as UI

Rectangle {

    id: scenarios

    property var model: null
    property var scenariosList: []
    property bool showEditMode: false

    Rectangle {
       id: noScenario

       visible: (model !== null && model !== undefined && !(model.rowCount() > 0))

       color: Colors.uTransparent

       anchors.fill: parent
       Rectangle
       {
           width: parent.width
           height: noScenarioLabel.height
           anchors.centerIn: parent
           ULabel.Default {
               id: noScenarioLabel
               anchors.horizontalCenter: parent.horizontalCenter
               text: "No scenarios available"
               width: parent.width * 0.75
               font.bold: true
               font.pointSize: 32
               horizontalAlignment: Text.AlignHCenter


               color: Colors.uGrey
           }
       }

       UI.UButton
       {
           id: createScenarioButton
           text: "Create new scenario"
           iconId: ""
           iconSize: 12
           width: 225
           anchors.bottom: parent.bottom
           anchors.left: parent.left
       }
    }

    Rectangle {
        id: scenarioContainer
        anchors.fill: parent

        visible: (model !== null && model !== undefined && model.rowCount() > 0)

        color: Colors.uTransparent

        Rectangle
        {
            id: scenarioHeader
            width: parent.width
            height: 50

            UI.UFontAwesome
            {
                id: scHeaderIcon
                iconId: "Cog"
                iconSize: 24
                iconColor: Colors.uGrey

                anchors.left: parent.left
                anchors.leftMargin: 15
                anchors.verticalCenter: parent.verticalCenter
            }

            ULabel.Default
            {
                text: "Scenario configuration"
                font.pointSize: 20
                anchors.left: scHeaderIcon.right
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: Colors.uGrey
            }
        }

        Scenario {
            id: currentScenario

            width: parent.width
            anchors.top: scenarioSelectionHeader.bottom
            anchors.topMargin: 95
            anchors.bottom: parent.bottom

            visible: (currentScenario.model != null)
        }

        Rectangle
        {
            id: scenarioEditHeader
            width: parent.width
            height: 35
            anchors.top: scenarioHeader.bottom

            visible: showEditMode

            UI.UTextbox
            {
                id: editScenarioName
                anchors.left: parent.left
                anchors.right: scenarioSaveCancel.left
                anchors.rightMargin: 10

                height: parent.height

                placeholderText: "Enter a scenario name"

                function validate() {
                    return text !== ""
                }

                state: (validate() ? "SUCCESS" : "ERROR")
            }

            UI.USaveCancel
            {
                id: scenarioSaveCancel
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                onCancel: toggleEditMode()
            }
        }

        Rectangle
        {
            id: scenarioSelectionHeader
            width: parent.width
            height: 35
            anchors.top: scenarioHeader.bottom

            visible: !showEditMode

            UI.UCombobox {
                id: scenarioCombo

                itemListModel: scenariosList

                anchors.left: parent.left
                anchors.right: editButton.left
                anchors.rightMargin: 10

                height: parent.height

                Component.onCompleted: {
                    selectItem(0)
                    currentScenario.model = scenarios.model.get(selectedItem)
                }

                onSelectedItemChanged: if (scenarios.model !== null && scenarios.model !== undefined) currentScenario.model = scenarios.model.get(selectedItem)
            }

            UI.UButton
            {
                id: editButton
                width: parent.height
                height: parent.height
                iconId: "pencil"

                anchors.right: deleteButton.left
                anchors.rightMargin: 5

                onClicked: toggleEditMode()
            }

            UI.UButton
            {
                id: deleteButton
                width: parent.height
                height: parent.height
                iconId: "Trash"

                buttonColor: Colors.uDarkRed
                buttonHoveredColor: Colors.uRed
                buttonTextColor : Colors.uWhite

                anchors.right: parent.right
            }
        }
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

                        onClicked: {
                            currentScenario.model = model;
                            main.addToBreadCrumb("scenario/Scenarios", model.name)
                        }
                    }

                }
            }
        }


    function toggleEditMode()
    {
        showEditMode = !showEditMode
        currentScenario.showEditMode = showEditMode

        if(currentScenario.model !== null)
        {
            editScenarioName.text = currentScenario.model.name
        }
    }
}
