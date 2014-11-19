import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../scenario" as Scenario
import "../ui/UColors.js" as Colors

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

    Rectangle
    {
        id: contentCanvas

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.leftMargin: devicePage.marginSize
        anchors.rightMargin: devicePage.marginSize
        anchors.topMargin: devicePage.marginSize
        anchors.bottomMargin: devicePage.bottomMarginSize

        color: Colors.uWhite
        radius: 5

        Rectangle
        {
            id: contentContainer
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            anchors.margins: devicePage.paddingSize

            color: Colors.uTransparent

            Rectangle
            {
                id: deviceInformationContainer
                anchors.left: parent.left
                anchors.right: leftToRightSeparator.right
                height: parent.height

                Rectangle
                {
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    anchors.rightMargin: devicePage.paddingSize

                    Loader {
                        id: deviceInfoLoader

                        active: false;
                        asynchronous: true;

                        anchors.fill: parent

                        source: "qrc:/qml/device/type/%1.qml".arg(getDeviceFile())
                        onVisibleChanged:      { loadIfNotLoaded(); }
                        Component.onCompleted: { loadIfNotLoaded(); }

                        function loadIfNotLoaded () {
                            // to load the file at first show
                            if (visible && !active) {
                                active = true;
                            }
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

    function getEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
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
}
