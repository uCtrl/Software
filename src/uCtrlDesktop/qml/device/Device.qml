import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../scenario" as Scenario
import "../ui/UColors.js" as Colors
import "../task" as Task

import "./type" as Type

import DeviceEnums 1.0
import HistoryEnums 1.0

Rectangle
{
    id: devicePage

    property variant model: main.activeDevice

    anchors.fill: parent
    color: Colors.uLightGrey

    property int marginSize: 20
    property int paddingSize: 20
    property int bottomMarginSize: 30

    property bool showEditMode: false

    Rectangle {
        id: contentCanvas

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.margins: devicePage.marginSize
        anchors.bottomMargin: devicePage.bottomMarginSize

        color:  Colors.uWhite
        radius: 5

        Rectangle {
            id: contentContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            anchors.margins: devicePage.paddingSize

            color: Colors.uTransparent

            Rectangle {
                id: infoContainer

                property int headerWidth: 125
                property int sectionPadding: 10

                property bool showEditMode: false

                color: Colors.uTransparent

                anchors.left: parent.left
                anchors.right: leftToRightSeparator.left
                anchors.rightMargin: devicePage.paddingSize

                anchors.top: parent.top
                anchors.bottom: parent.bottom

                Rectangle {
                    id: nameContainer

                    anchors.top: infoContainer.top
                    anchors.left: infoContainer.left
                    anchors.right: infoContainer.right

                    height: iconContainer.height

                    color: Colors.uTransparent

                    Rectangle {
                        id: iconContainer

                        anchors.left: nameContainer.left
                        anchors.top: nameContainer.top

                        width: 50
                        height: width

                        radius: 10
                        color: {
                            switch(getDeviceStatus())
                            {
                            case 0:
                                return Colors.uGreen;   // OK
                            case 1:
                                return Colors.uYellow;  // Disconnected
                            case 2:
                                return Colors.uRed;     // Warning
                            }
                        }

                        UI.UFontAwesome {
                            id: deviceIcon

                            iconId: getDeviceIcon()
                            iconColor: Colors.uWhite
                            iconSize: 20
                            anchors.centerIn: parent
                        }
                    }

                    UI.UButton {
                        id: editButton

                        iconId: "pencil"

                        iconSize: 22

                        anchors.top: nameContainer.top
                        anchors.right: nameContainer.right

                        anchors.bottom: nameContainer.bottom

                        width: 40

                        buttonTextColor: Colors.uGrey
                        buttonColor: Colors.uTransparent
                        buttonHoveredTextColor: Colors.uGreen
                        buttonHoveredColor: Colors.uTransparent

                        onClicked: infoContainer.showEditMode = !infoContainer.showEditMode

                        visible : !infoContainer.showEditMode
                    }

                    UI.USaveCancel {
                        id: saveCancelDevice

                        anchors.top: parent.top
                        anchors.right: parent.right

                        //width: parent.width / 5
                        height: iconContainer.height

                        onSave: infoContainer.showEditMode = !infoContainer.showEditMode
                        onCancel: infoContainer.showEditMode = !infoContainer.showEditMode

                        visible: infoContainer.showEditMode
                    }

                    ULabel.Description {
                        text: getDeviceName()

                        font.bold: true
                        font.pointSize: 22

                        anchors.verticalCenter: iconContainer.verticalCenter
                        anchors.left: iconContainer.right
                        anchors.right: editButton.left

                        anchors.margins: 10

                        visible : !infoContainer.showEditMode
                    }

                    UI.UTextbox {
                        id: nameTextbox

                        anchors.top: nameContainer.top

                        anchors.left: iconContainer.right
                        anchors.leftMargin: 10

                        anchors.right: saveCancelDevice.left
                        anchors.rightMargin: 10

                        anchors.verticalCenter: iconContainer.verticalCenter

                        text: getDeviceName()
                        placeholderText: "Device name"

                        function validate() {
                            return text !== ""
                        }

                        state: (validate() ? "SUCCESS" : "ERROR")

                        visible: infoContainer.showEditMode
                    }
                }

                Rectangle {
                    id: statusContainer

                    color: Colors.uTransparent

                    anchors.top: nameContainer.bottom
                    anchors.left: infoContainer.left
                    anchors.right: infoContainer.right

                    height: 40

                    ULabel.DeviceInfoHeaderLabel {
                        id: statusLabel

                        text: "Status"
                        width: infoContainer.headerWidth

                        anchors.left: statusContainer.left
                    }

                    Rectangle {
                        id: statusSwitchContainer
                        anchors.left: statusLabel.right
                        anchors.leftMargin: 10

                        width: infoContainer.valueWidth
                        height: statusInfoBoundedLabel.height

                        anchors.verticalCenter: statusContainer.verticalCenter

                        ULabel.UInfoBoundedLabel {
                            id: statusInfoBoundedLabel

                            Component.onCompleted: {
                                switch(getDeviceStatus()) {
                                case 0:
                                    text = "OK";
                                    boundedColor = Colors.uGreen;
                                    break;
                                case 1:
                                    text = "DISCONNECTED";
                                    boundedColor = Colors.uYellow;
                                    break;
                                case 2:
                                    text = "WARNING";
                                    boundedColor = Colors.uRed;
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    id: enabledContainer

                    color: Colors.uTransparent

                    anchors.top: statusContainer.bottom
                    anchors.left: infoContainer.left
                    anchors.right: infoContainer.right

                    height: 30

                    ULabel.DeviceInfoHeaderLabel {
                        id: enabledLabel

                        text: "Enabled"
                        width: 125

                        anchors.left: enabledContainer.left
                    }

                    Rectangle {
                        id: enabledSwitchContainer
                        anchors.left: enabledLabel.right
                        anchors.leftMargin: 10

                        width: 100
                        height: enabledInfoBoundedLabel.height

                        anchors.verticalCenter: enabledContainer.verticalCenter

                        ULabel.UInfoBoundedLabel {
                            id: enabledInfoBoundedLabel

                            text: (getDeviceEnabled())
                            boundedColor: (getDeviceEnabled() === "ON" ? Colors.uGreen : Colors.uGrey)

                            visible: !infoContainer.showEditMode
                        }

                        UI.USwitch {
                            id: enabledSwitch

                            state: getDeviceEnabled()

                            anchors.left: enabledLabel.right
                            anchors.leftMargin: 10

                            anchors.verticalCenter: enabledSwitchContainer.verticalCenter
                            visible: infoContainer.showEditMode
                        }
                    }
                }

                Rectangle {
                    id: fileContainer

                    color: Colors.uTransparent

                    anchors.left: infoContainer.left
                    anchors.right: infoContainer.right

                    anchors.top: enabledContainer.bottom
                    anchors.bottom: infoContainer.bottom

                    ULabel.Default {
                        text: "File"

                        font.bold: true
                        font.pixelSize: 24

                        anchors.centerIn: parent

                        color: Colors.uWhite
                    }

                    Loader {
                        id: fileLoader

                        active: false
                        asynchronous: true

                        anchors.fill: parent

                        onVisibleChanged:      { loadIfNotLoaded(); }
                        Component.onCompleted: { loadIfNotLoaded(); }

                        function loadIfNotLoaded () {
                            // to load the file at first show
                            if (visible && !active) {
                                active = true;
                            }

                            setSource("type/" + getDeviceFile() + ".qml", { "model" : model });
                        }
                    }
                }
            }

            Rectangle
            {
                id: leftToRightSeparator
                width: 2
                height: parent.height
                anchors.right: scenariosAndLogsContainer.left
                color: Colors.uLightGrey
            }

            Rectangle
            {
                id: scenariosAndLogsContainer
                width: parent.width * 0.5
                height: parent.height
                anchors.right: parent.right

                Rectangle
                {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    anchors.leftMargin: devicePage.paddingSize

                    Rectangle
                    {
                        id: tabsContainer
                        width: parent.width
                        height: 30

                        UI.UTabs {
                            id: tabs

                            anchors.centerIn: parent

                            width: 300
                            height: parent.height

                            iconColor: Colors.uWhite
                            showText: true

                            items: [
                                { icon: "Cog", value: "scenario", text: "Scenarios" },
                                { icon: "BarChart", value: "log", text: "System Logs" }
                            ]

                            Component.onCompleted: tabs.selectedValue = "scenario"
                        }
                    }

                    Rectangle
                    {
                        id: configContainer
                        width: parent.width
                        anchors.top: tabsContainer.bottom
                        anchors.bottom: parent.bottom

                        Rectangle
                        {
                            id: scenarioContainer
                            anchors.fill: parent
                            anchors.topMargin: 10
                            visible: tabs.selectedValue === "scenario"

                            Scenario.Scenarios {
                                id: scenariosList

                                model: getScenarios()

                                editTaskFunction: taskEditor.editTask
                                anchors.fill: parent
                            }
                        }

                        Rectangle
                        {
                            id: logsContainer
                            anchors.fill: parent
                            visible: tabs.selectedValue === "log"

                            Rectangle
                            {
                                id: logsHeaderContainer
                                width: parent.width
                                height: 50

                                UI.UFontAwesome
                                {
                                    id: logsHeaderIcon
                                    iconId: "info"
                                    iconSize: 24
                                    iconColor: Colors.uGrey

                                    anchors.left: parent.left
                                    anchors.leftMargin: 15
                                    anchors.verticalCenter: parent.verticalCenter
                                }

                                ULabel.Default
                                {
                                    text: "Device events"
                                    font.pointSize: 20
                                    anchors.left: logsHeaderIcon.right
                                    anchors.leftMargin: 20
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: Colors.uGrey
                                }
                            }

                            Rectangle
                            {
                                id: logsContentContainer
                                width: parent.width
                                anchors.top: logsFilterContainer.bottom
                                anchors.topMargin: 10
                                anchors.bottom: parent.bottom
                                clip: true
                                Logs
                                {
                                    id: logs
                                    anchors.fill: parent
                                    logsModel: getHistory()
                                }
                            }

                            Rectangle
                            {
                                id: logsFilterContainer
                                width: parent.width
                                height: 40
                                anchors.top: logsHeaderContainer.bottom

                                UI.UCombobox
                                {
                                    id: filterType
                                    width: 150
                                    height: parent.height
                                    itemListModel: [
                                        { value:"Any", displayedValue:"Any event", iconId:""},
                                        { value:"Action", displayedValue:"Action", iconId:""},
                                        { value:"Condition", displayedValue:"Condition", iconId:""},
                                        { value:"Scenario", displayedValue:"Scenario", iconId:""},
                                        { value:"Status", displayedValue:"Status", iconId:""},
                                        { value:"Update", displayedValue:"Update", iconId:""},
                                    ]
                                    Component.onCompleted: selectItem(0)
                                }

                                UI.UCombobox
                                {
                                    id: filterDate
                                    anchors.left: filterType.right
                                    anchors.leftMargin: 10
                                    anchors.right: parent.right
                                    height: parent.height
                                    itemListModel: [
                                        { value:"Any", displayedValue:"Any date", iconId:""},
                                        { value:"Today", displayedValue:"Today", iconId:""},
                                        { value:"Week", displayedValue:"This week", iconId:""},
                                        { value:"Month", displayedValue:"This month", iconId:""},
                                        { value:"Yeah", displayedValue:"This year", iconId:""},
                                    ]
                                    Component.onCompleted: selectItem(0)
                                }
                            }
                        }
                    }


                    Task.TaskEditor
                    {
                        id: taskEditor

                        visible: false

                        function editTask(tasks, conditions)
                        {
                            taskModel = tasks
                            conditionModel = conditions
                            visible = true
                        }
                    }
                }
            }
        }
    }

    Rectangle
    {
        width: parent.width - devicePage.marginSize
        height: devicePage.bottomMarginSize
        color: Colors.uTransparent

        UI.UFontAwesome
        {
            id: updateIcon
            iconId: "earth"
            iconSize: 12
            iconColor: Colors.uGrey
            anchors.right: updateText.left
            anchors.rightMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }
        ULabel.Default
        {
            id: updateText
            text: getLastUpdatedText()
            anchors.right: parent.right
            color: Colors.uGrey
            anchors.verticalCenter: parent.verticalCenter
        }

        anchors.bottom: parent.bottom
    }

    function getType() {
        if (model !== null) return model.type
        else return 0
    }

    function getLastUpdatedText() {
        if (model !== null && model.lastUpdate !== undefined) return model.lastUpdate
        else return "Last updated a second ago."
    }

    function getScenarios() {
        if (model !== null) return main.devicesList.nestedModelFromId(model.id)
    }

    function getDescription() {
        if (model !== null) return model.description
        else return ""
    }

    function saveForm() {
        if (model !== null) {
            if (nameTextbox.text !== "") model.name = nameTextbox.text
            model.isEnabled = (enabledSwitch.state === "ON")
        }

        toggleEditMode()
    }

    function getHistory() {
        if (model !== null) return main.devicesList.getHistoryWithId(model.id)
        else return null;
    }

    function getDeviceFile() {
        if (model !== null) {
            switch(model.type) {
                case UEType.BelkinWeMoSocket:
                    return "Weemo"
                case UEType.Humidity:
                    return "Humidity"
                case UEType.Light:
                    return "Light"
                case UEType.LightSensor:
                    return "LightSensor"
                case UEType.NinjasEyes:
                    return "NinjaEyes"
                case UEType.OnBoardRGBLed:
                    return "LED"
                case UEType.PIRMotionSensor:
                    return "MotionSensor"
                case UEType.ProximitySensor:
                    return "ProximitySensor"
                case UEType.PushButton:
                    return "PushButton"
                case UEType.RF4333:
                    return "RF"
                case UEType.StatusLight:
                    return "StatusLight"
                case UEType.Switch:
                    return "Switch"
                case UEType.Temperature:
                    return "Temperature"
            }
        }
        return "Error"
    }

    function getDeviceStatus() {
        if (model !== null) return model.status
        else return 2
    }

    function getDeviceIcon() {
        if (model !== null) {
            switch(model.type) {
                case UEType.BelkinWeMoSocket:
                    return "droplet"
                case UEType.Humidity:
                    return "droplet"
                case UEType.Light:
                    return "droplet"
                case UEType.LightSensor:
                    return "droplet"
                case UEType.NinjasEyes:
                    return "droplet"
                case UEType.OnBoardRGBLed:
                    return "droplet"
                case UEType.PIRMotionSensor:
                    return "droplet"
                case UEType.ProximitySensor:
                    return "droplet"
                case UEType.PushButton:
                    return "droplet"
                case UEType.RF4333:
                    return "droplet"
                case UEType.StatusLight:
                    return "droplet"
                case UEType.Switch:
                    return "droplet"
                case UEType.Temperature:
                    return "droplet"
            }
        }
        return "droplet"
    }

    function getDeviceName() {
        if (model !== null) return model.name
        else return "Unknown device name"
    }

    function getDeviceEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
    }
}
