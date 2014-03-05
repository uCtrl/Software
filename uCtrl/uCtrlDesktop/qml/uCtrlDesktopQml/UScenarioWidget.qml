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

        UConfigTaskWidget {
            id: task1
            anchors.top: parent.top
            status: "50%"
        }
    }

    UScenarioConditionWidget {
        id: scenarioCondition
        anchors.bottom: parent.bottom
    }

}
