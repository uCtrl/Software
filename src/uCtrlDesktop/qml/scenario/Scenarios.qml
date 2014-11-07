import QtQuick 2.0

import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: container

    property var model: null

    color: Colors.uTransparent

    Rectangle {
        id: rectScenarios

        anchors.left: container.left
        anchors.right: container.right
        anchors.top: container.top
        anchors.bottom: container.bottom

        color: Colors.uTransparent

        visible: (currentScenario.model === null)

        ULabel.Default {
            id: pleaseLabel

            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter

            text: "Please select a scenario"

            color: Colors.uGrey

        }

        ListView {
            id: scenarios

            anchors.top: pleaseLabel.bottom
            anchors.topMargin: 10

            anchors.bottom: parent.bottom

            anchors.left: parent.left
            anchors.right: parent.right

            model: container.model

            delegate: Column {
                id: column

                width: parent.width

                ScenarioListItem {
                    id: itemContainer

                    width: parent.width;
                    height: 40

                    item: model

                    MouseArea {
                        id: mouseArea

                        anchors.fill: parent
                        hoverEnabled: true

                        onClicked: {
                            currentScenario.model = model;
                            main.addToBreadCrumb("scenario/Scenarios", model.name)
                        }
                    }
                }
            }
        }
    }

    Scenario {
        id: currentScenario

        anchors.left: container.left
        anchors.right: container.right
        anchors.top: container.top
        anchors.bottom: container.bottom

        visible: (currentScenario.model != null)
    }
}
