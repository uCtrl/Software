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
        /*
        UConfigTaskWidget {
            id: task2
            anchors.top: task1.bottom
            status: "100%"
        }
        UConfigTaskWidget {
            id: task3
            anchors.top: task2.bottom
            status: "0%"
        }
        UConfigTaskWidget {
            id: task4
            anchors.top: task3.bottom
            status: "10%"
        }
        UConfigTaskWidget {
            id: task5
            anchors.top: task4.bottom
            status: "21.38%"
        }
        */
    }

    UScenarioConditionWidget {
        id: scenarioCondition
        anchors.bottom: parent.bottom
    }

}
