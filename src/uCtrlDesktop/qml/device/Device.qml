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

    onModelChanged: {
        uCtrlApiFacade.getDeviceAllStats(devicesList.findObject(model.id),
                                         {"from": new Date().setMinutes(0, 0).toString(),
                                          "to": new Date().getTime().toString(),
                                          "interval": "15min",
                                          "fn": "mean"});
        uCtrlApiFacade.getDeviceHistory(devicesList.findObject(model.id));
        showEditMode = false
    }

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

                        DeviceIcon
                        {
                            deviceType: devicePage.model === null ? 0 : devicePage.model.type
                            iconColor: Colors.uWhite
                            iconSize: 24
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

                        anchors.right: parent.right
                        anchors.verticalCenter: iconContainer.verticalCenter

                        height: 30

                        onSave: {
                            saveForm();
                            infoContainer.showEditMode = !infoContainer.showEditMode;
                        }
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

                        anchors.left: iconContainer.right
                        anchors.leftMargin: 10

                        anchors.right: saveCancelDevice.left
                        anchors.rightMargin: 10

                        anchors.verticalCenter: iconContainer.verticalCenter

                        height: 30

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

                            anchors.left: enabledSwitchContainer.left
                            anchors.verticalCenter: enabledSwitchContainer.verticalCenter

                            visible: infoContainer.showEditMode
                        }
                    }
                }

                Rectangle {
                    id: techContainer

                    property bool hidden: true

                    anchors.left: infoContainer.left
                    anchors.right: infoContainer.right

                    anchors.top: enabledContainer.bottom
                    anchors.topMargin: 10

                    height: (hidden ? 25 : techInfoColumn.height + techIcon.height + 20)

                    radius: 4

                    color: (techContainerMouse.containsMouse ? Colors.uUltraLightGrey : Colors.uWhite)

                    Rectangle {
                        id: techContainerSeparator

                        anchors.left: techContainer.left
                        anchors.right: techContainer.right
                        anchors.top: techContainer.top

                        height: 1

                        color: Colors.uUltraLightGrey
                    }

                    UI.UFontAwesome {
                        id: techIcon

                        iconId: "Cog"
                        iconSize: 12
                        iconColor: Colors.uGrey

                        anchors.top: techContainer.top
                        anchors.topMargin: 12

                        anchors.left: techContainer.left
                        anchors.leftMargin: 10
                    }

                    ULabel.Default {
                        id: techLabel

                        font.bold: false
                        font.pixelSize: 11

                        anchors.verticalCenter: techIcon.verticalCenter
                        anchors.left: techIcon.right
                        anchors.leftMargin: 13

                        text: (techContainer.hidden ? "Show technical information" : "Hide technical information")

                        font.underline: techContainerMouse.containsMouse
                        color: Colors.uGrey

                    }

                    Column {
                        id: techInfoColumn

                        anchors.left: techContainer.left
                        anchors.right: techContainer.right
                        anchors.top: techLabel.bottom

                        Repeater {
                            model: [{title: "MODEL", value: getModel()},
                                    {title: "TYPE", value: getType()},
                                    {title: "GUID", value: getGUID()},
                                    {title: "RANGE", value: "from " + getMinValue() + " to " + getMaxValue()}]

                            Rectangle {
                                color: Colors.uTransparent
                                height: 20; width: techInfoColumn.width;

                                Row {
                                    spacing: 10

                                    anchors.top: parent.top
                                    anchors.topMargin: 5

                                    anchors.left: parent.left
                                    anchors.leftMargin: 22

                                    ULabel.Default {
                                        text: modelData.title
                                        anchors.top: parent.top
                                        anchors.leftMargin: 15

                                        font.pixelSize: 10
                                        font.bold: true

                                        width: 35

                                        color: Colors.uGrey
                                    }

                                    ULabel.Default {
                                        text: modelData.value
                                        anchors.top: parent.top
                                        anchors.leftMargin: 15

                                        font.pixelSize: 10
                                        font.bold: false

                                        color: Colors.uGrey
                                    }
                                }
                            }
                        }

                        visible: !techContainer.hidden
                    }

                    MouseArea {
                        id: techContainerMouse

                        anchors.fill: techContainer
                        hoverEnabled: true

                        onClicked: techContainer.hidden = !techContainer.hidden
                    }
                }

                Rectangle {
                    id: descriptionContainer

                    property bool hidden: true

                    anchors.left: infoContainer.left
                    anchors.right: infoContainer.right

                    anchors.top: techContainer.bottom
                    height: (hidden ? 25 : 50)

                    radius: 4

                    color: (descriptionContainerMouse.containsMouse ? Colors.uUltraLightGrey : Colors.uWhite)

                    UI.UFontAwesome {
                        id: descriptionIcon

                        iconId: "File"
                        iconSize: 12
                        iconColor: Colors.uGrey

                        anchors.top: descriptionContainer.top
                        anchors.topMargin: 12

                        anchors.left: descriptionContainer.left
                        anchors.leftMargin: 10
                    }

                    ULabel.Default {
                        id: descriptionLabel

                        font.bold: false
                        font.pixelSize: 11

                        anchors.verticalCenter: descriptionIcon.verticalCenter
                        anchors.left: descriptionIcon.right
                        anchors.leftMargin: 13

                        text: (descriptionContainer.hidden ? "Show device description" : "Hide device description")

                        font.underline: descriptionContainerMouse.containsMouse
                        color: Colors.uGrey

                    }

                    ULabel.Description {
                        id: descriptionValue

                        font.pixelSize: 12
                        color: Colors.uMediumDarkGrey

                        anchors.top: descriptionLabel.bottom
                        anchors.topMargin: 7

                        anchors.left: descriptionContainer.left
                        anchors.leftMargin: 22

                        text: getDescription()

                        visible: !descriptionContainer.hidden
                    }

                    Rectangle {
                        id: descriptionContainerSeparator

                        anchors.left: descriptionContainer.left
                        anchors.right: descriptionContainer.right
                        anchors.bottom: descriptionContainer.bottom

                        height: 1

                        color: Colors.uUltraLightGrey
                    }

                    MouseArea {
                        id: descriptionContainerMouse

                        anchors.fill: descriptionContainer
                        hoverEnabled: true

                        onClicked: descriptionContainer.hidden = !descriptionContainer.hidden
                    }
                }

                Rectangle {
                    id: fileContainer

                    color: Colors.uTransparent

                    anchors.left: infoContainer.left
                    anchors.right: infoContainer.right

                    anchors.top: descriptionContainer.bottom
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

    function getLastUpdatedText() {
        if (model !== null && model.lastUpdate !== undefined) return model.lastUpdate
        else return "Last updated a second ago."
    }

    function getScenarios() {
        if (model !== null) return main.devicesList.nestedModelFromId(model.id)
    }

    function saveForm() {
        model.name = nameTextbox.text
        model.isEnabled = (enabledSwitch.state === "ON")
        uCtrlApiFacade.putDevice(devicesList.findObject(model.id))
    }

    function getHistory() {
        if (model !== null) return main.devicesList.getHistoryWithId(model.id)
        else return null;
    }

    function getDeviceFile() {
        if (model !== null) {
            switch(model.type) {
                case UEType.PowerSocketSwitch:
                    return "PowerSocketSwitch"
                case UEType.PushButton:
                    return "PushButton"
                case UEType.MotionSensor:
                    return "MotionSensor"
                case UEType.Humidity:
                    return "Humidity"
                case UEType.Temperature:
                    return "Temperature"
                case UEType.NinjasEyes:
                    return "NinjaEyes"
                case UEType.LimitlessLEDWhite:
                    return "LimitlessLEDWhite"
                case UEType.DoorSensor:
                    return "DoorSensor"
            }
        }
        return "Error"
    }

    function getDeviceStatus() {
        if (model !== null) return model.status
        else return 2
    }

    function getDeviceName() {
        if (model !== null) return model.name
        else return "Unknown device name"
    }

    function getDeviceEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
    }

    function getModel() {
        if (model !== null) return model.deviceModel
        else return "La Crosse Temp WS2355"
    }

    function getType() {
        return "Thermometer (sensor)"
    }

    function getGUID() {
        return "12312412412321"
    }

    function getMinValue() {
        if (model !== null) return model.minValue
        else return "-70"
    }

    function getMaxValue() {
        if (model !== null) return model.maxValue
        else return "70"
    }

    function getDescription() {
        if (model !== null) return model.description
        else return ""
    }
}
