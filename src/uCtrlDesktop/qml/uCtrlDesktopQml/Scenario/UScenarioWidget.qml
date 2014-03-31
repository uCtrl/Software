import QtQuick 2.0

Rectangle {
    property string name: "UNKNOWN"
    property ListModel scenario: null
    clip:true

    color: _colors.uWhite
    height: parent.height
    width: parent.width

    function getName() {
        return (device === undefined || device === null ? "UNKNOWN" : device.name)
    }

    function getRoom() {
        return (device === undefined || device === null ? "UNKNOWN" : "UNKNOWN" /*device.room*/)
    }

    function getImagePath() {
        var imagePaths = [ "a", "b", "c", "d"]
        return imagePaths[(device === undefined || device === null ? 0 : device.type)]
    }

    function refresh(newScenario) {
        scenarioHeader.refresh(newScenario.name)
        taskList.model = newScenario
    }

    UScenarioHeaderWidget {
        id: scenarioHeader
        anchors.top: parent.top
        scenarioName: name
    }

    Rectangle {
        id: scenarioTask
        clip:true

        anchors.top: scenarioHeader.bottom
        anchors.bottom: parent.bottom

        width: parent.width

        color: _colors.uTransparent
        visible: true

        ListView {
            id: taskList
            anchors.fill: parent

            model: scenario
            delegate: UTaskWidget {  }
        }
    }
}
