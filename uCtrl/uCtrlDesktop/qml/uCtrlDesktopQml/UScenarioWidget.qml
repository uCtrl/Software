import QtQuick 2.0

Rectangle {
    property string name: "UNKNOWN"
    color: "transparent"
    width: parent.width

    UScenarioHeaderWidget {
        id: scenarioHeader
        anchors.top: parent.top
        scenarioName: name
    }

    Rectangle {
        id: scenarioTask
        anchors.top: scenarioHeader.bottom
        anchors.bottom: scenarioCondition.top
        width: parent.width
        color: "transparent"

        ListView {
            id: taskList
            anchors.fill: parent

            model: myScenarioModel
            delegate: UConfigTaskWidget {
                status: taskStatus;
            }
        }
    }

    UScenarioConditionWidget {
        id: scenarioCondition
        anchors.bottom: parent.bottom
    }

}
