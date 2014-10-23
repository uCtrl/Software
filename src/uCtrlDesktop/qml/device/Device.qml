import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../scenario" as Scenario
import "../ui/UColors.js" as Colors
import "../history" as history

import "./type" as Type

import DeviceEnums 1.0

Rectangle {

    id: deviceInfo

    anchors.fill: parent

    property variant model: main.activeDevice
    property bool showEditMode: false

    color: Colors.uTransparent

    Rectangle {
        id: deviceHeader

        property int marginSize: 20

        color: Colors.uWhite

        anchors.top: parent.top
        anchors.left: parent.left

        anchors.margins: marginSize

        width: (parent.width / 2) - (marginSize * 2);
        height: 150

        Rectangle {
            id: icon

            anchors.top: parent.top
            anchors.left: parent.left

            anchors.margins: deviceHeader.marginSize

            height: 40; width: 40

            color: Colors.uGreen

            radius: 4

            ULabel.Default {
                id: type

                anchors.centerIn: parent

                color: Colors.uWhite

                font.pointSize: 18
                font.bold: false

                text: getIcon()
            }
        }

        Rectangle {
            id: buttonContainer

            anchors.right: parent.right
            anchors.top: parent.top

            anchors.margins: deviceHeader.marginSize

            width: showEditMode ? saveCancelPlatform.width : editButton.width

            anchors.verticalCenter: icon.verticalCenter

            UI.UButton {
                id: editButton

                iconId: "pencil"

                iconSize: 22

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                height: 40; width: 40

                buttonTextColor: Colors.uGrey
                buttonColor: Colors.uTransparent
                buttonHoveredTextColor: Colors.uGreen
                buttonHoveredColor: Colors.uTransparent

                onClicked: showEditMode = true

                visible: !showEditMode
            }

            UI.USaveCancel {
                id: saveCancelPlatform

                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right

                onSave: saveForm()
                onCancel: toggleEditMode()

                visible: showEditMode
            }
        }

        Rectangle {
            id: nameContainer

            anchors.left: icon.right
            anchors.right: buttonContainer.left

            anchors.verticalCenter: icon.verticalCenter

            anchors.margins: 10

            ULabel.Default {
                id: nameLabel

                anchors.verticalCenter: parent.verticalCenter

                anchors.left: parent.left
                anchors.right: parent.right

                font.pointSize: 24
                font.bold: true

                color: Colors.uBlack

                text: getName()

                visible: !showEditMode
            }

            UI.UTextbox {
                id: nameTextbox

                anchors.verticalCenter: parent.verticalCenter

                anchors.left: parent.left
                anchors.right: parent.right

                height: 40

                text: getName()
                placeholderText: "Enter device name"

                function validate() {
                    return text !== ""
                }

                visible: showEditMode

                state: (validate() ? "SUCCESS" : "ERROR")
            }
        }

        Rectangle {
            id: enabledContainer

            anchors.left: parent.left
            anchors.top: icon.bottom

            anchors.topMargin: deviceHeader.marginSize / 2

            height: 25; width: (parent.width / 2)

            ULabel.UInfoTitle {
                id: enabledTitle

                text: "STATUS"

                anchors.left: parent.left
                anchors.leftMargin: deviceHeader.marginSize

                anchors.verticalCenter: parent.verticalCenter;
                width: 150
            }

            ULabel.UInfoBoundedLabel {
                id: enabledStatusLabel
                text: getEnabled()

                anchors.left: enabledTitle.right
                anchors.verticalCenter: parent.verticalCenter

                visible: !showEditMode
            }

            UI.USwitch {
                id: enabledSwitch

                anchors.left: enabledTitle.right
                anchors.verticalCenter: parent.verticalCenter

                state: getEnabled()

                visible: showEditMode
            }
        }

        Rectangle {
            id: updateContainer

            anchors.right: parent.right
            anchors.verticalCenter: enabledContainer.verticalCenter

            height: 25; width: 220

            UI.UFontAwesome {
                id: updateIcon

                anchors.left: parent.left
                anchors.margins: 5
                anchors.verticalCenter: parent.verticalCenter

                iconSize: 14
                iconId: "Time"
                iconColor: Colors.uGrey
            }

            ULabel.Default {
                id: updateText

                text: getUpdate()

                anchors.left: updateIcon.right
                anchors.right: parent.right

                anchors.margins: 12

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 14
                font.bold: false
                font.family: "Lato"

                color: Colors.uGrey
            }
        }

        Rectangle {
            id: descriptionContainer

            anchors.left: parent.left
            anchors.leftMargin: deviceHeader.marginSize

            anchors.right: parent.right
            anchors.rightMargin: deviceHeader.marginSize

            anchors.top: updateContainer.bottom
            anchors.topMargin: (deviceHeader.marginSize / 2)

            anchors.bottom: parent.bottom

            ULabel.UInfoTitle {
                id: descriptionTitle

                text: "DESCRIPTION"

                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter

                width: 150
            }

            ULabel.Link {
                id: descriptionLink

                text: "Show more"

                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter

                color: descriptionTitle.color
            }

            ULabel.Default {
                id: descriptionLabel

                text: getDescription()

                anchors.left: descriptionTitle.right
                anchors.right: descriptionLink.left

                anchors.verticalCenter: parent.verticalCenter
                color: descriptionTitle.color
            }
        }
    }

    Rectangle {
        id: deviceOverview

        property int marginSize: 20

        anchors.left: parent.left

        anchors.top: deviceHeader.bottom
        anchors.bottom: parent.bottom

        anchors.margins: marginSize

        width: deviceHeader.width

        Loader {
            id: deviceLoader

            active: false;
            asynchronous: true;

            height: parent.height; width: parent.width

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

    Rectangle {
        id: configuration

        property int marginSize: deviceHeader.marginSize

        anchors.left: deviceHeader.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.margins: marginSize

        color: Colors.uWhite

        Rectangle {
            id: tabsContainer

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 10

            height: 40

            color: Colors.uTransparent

            UI.UTabs {
                id: tabs

                anchors.centerIn: parent

                height: 30; width: 300

                iconColor: Colors.uWhite
                showText: true

                items: [
                    { icon: "BarChart", value: "scenario", text: "Scenarios" },
                    { icon: "BarChart", value: "log", text: "System Logs" }
                ]

                Component.onCompleted: tabs.selectedValue = "scenario"
            }
        }

        Rectangle {
            id: scenariosContainer

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: tabsContainer.bottom
            anchors.bottom: parent.bottom

            anchors.margins: configuration.marginSize

            color: Colors.uTransparent

            visible: tabs.selectedValue === "scenario"

            Scenario.Scenarios {
                id: scenariosList

                model: getScenarios()
                anchors.fill: parent
            }
        }

        Rectangle {
            id: logsContainer

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: tabsContainer.bottom
            anchors.bottom: parent.bottom

            anchors.margins: configuration.marginSize

            visible: tabs.selectedValue === "log"

            color: Colors.uTransparent


            //LOGS ////////////////////////////////////////////////
            ListView {
                id: devicesList

                anchors.fill: parent

                model: parent.model

                property variant currentItem: null

                delegate: Column {
                    id: column

                    width: parent.width
                    DeviceListItem {

                        id: listItem

                        item: model

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                main.devicesList = devicesList.model
                                main.activeDevice = model
                                main.currentPage = "device/Device"
                            }
                        }
                    }
                }
            }
        }
    }

    function getName() {
        if (model !== null) return model.name
        else return "Device name"
    }

    function getEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
    }

    function getType() {
        if (model !== null) return model.type
        else return 0
    }

    function getIcon() {
        if (model !== null) {
            switch(model.type) {
                case UEType.BelkinWeMoSocket:
                    return "B"
                case UEType.Humidity:
                    return "H"
                case UEType.Light:
                    return "L"
                case UEType.LightSensor:
                    return "LS"
                case UEType.NinjasEyes:
                    return "NE"
                case UEType.OnBoardRGBLed:
                    return "LED"
                case UEType.PIRMotionSensor:
                    return "MS"
                case UEType.ProximitySensor:
                    return "PS"
                case UEType.PushButton:
                    return "PB"
                case UEType.RF4333:
                    return "RF"
                case UEType.StatusLight:
                    return "SL"
                case UEType.Switch:
                    return "S"
                case UEType.Temperature:
                    return "T"
            }
        }
        return "ERR"
    }

    function getDeviceFile() {
        if (model !== null) {
            switch(model.type) {
                case UEType.BelkinWeMoSocket:
                    return "Weemo"
                case UEType.Humidity:
                    return "Humidity"
                /*case UEType.Light:
                    return "Light"
                case UEType.LightSensor:
                    return "LightSensor"
                case UEType.NinjasEyes:
                    return "NinjasEyes"
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
                    return "Switch"*/
                case UEType.Temperature:
                    return "Temperature"
            }
        }
        return "Error"
    }

    function getUpdate() {
        if (model !== null && model.lastUpdate !== undefined) return model.lastUpdate
        else return "Last update a second ago."
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
            if (nameTextbox.text != "") model.name = nameTextbox.text
            model.isEnabled = (enabledSwitch.state === "ON")
        }

        toggleEditMode()
    }

    function toggleEditMode() {
        if (model !== null) {
            nameTextbox.text = getName()
            enabledSwitch.state = getEnabled()
        }

        showEditMode = !showEditMode
    }
}
