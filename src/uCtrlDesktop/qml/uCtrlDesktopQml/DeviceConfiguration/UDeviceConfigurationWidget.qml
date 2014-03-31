import QtQuick 2.0
import "../Device" as Device
import "../UI" as UI
import "../Scenario" as Scenario

UI.UFrame {
    property variant device: null
    property ListModel scenarios: null

    title: qsTr("Configuration")
    requiredModel: true

    function refresh(newDevice) {
        deviceHeader.refresh(newDevice)
        scenarioWidget.refresh(newDevice.getScenario())
        device = newDevice
    }

    Device.UHeader {
        id: deviceHeader

        device: device
    }

    Scenario.UScenarioWidget {
        id: scenarioWidget

        anchors.top: deviceHeader.bottom
        height: parent.height - deviceHeader.height - 80
        name: "Scenario #1 - Semaine de travail"
    }

    Rectangle {
        id: commandButtons

        width: parent.width
        height: 40
        anchors.top: scenarioWidget.bottom

        color: _colors.uUltraLightGrey

        UI.UButton {
            id: btnAdd

            objectName: "btn"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 7
            width: 96; height: 27
            x: 10
            text: qsTr("Add")

            function execute() {
                var pScenario = device.getScenario()
                var pTask = pScenario.createTask()
                pTask.setStatus("Undefined")
                pScenario.addTask(pTask)
            }
        }
    }
}
