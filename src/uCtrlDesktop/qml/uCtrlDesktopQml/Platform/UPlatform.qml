import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property var platform: {"enabled": "ON", "name": "UNKNOWN", "room": "UNKNOWN", "ip": "UNKNOWN", "id": "UNKOWN", "port": "UNKNOWN", "firmwareVersion": "UNKNOWN"}
    property bool isEditing : false
    property int animationTime: 350

    state: "HideAdvanced"

    states : [
        State {
            name: "ShowAdvanced"
            PropertyChanges { target: advancedInformation; height: 40 * 4 }
        },
        State {
            name: "HideAdvanced"
            PropertyChanges { target: advancedInformation; height: 0 }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation { target: advancedInformation; duration: animationTime; property: "height"; easing.type: Easing.InOutQuad }
        }
    ]

    function startEditing() {
        isEditing = true

        platformNameTextBox.text = platform.name
        locationTextbox.text = platform.room
    }

    function saveEditing() {
        isEditing = false

        container.platform.name = platformNameTextBox.text;
        container.platform.room = locationTextbox.text;
        container.platform.enabled = enabledSwitch.state;

        container.refresh(platform);
        systemFrame.notify();
    }

    function cancelEditing() {
        isEditing = false
    }

    function refresh(newPlatform) {
        platform = newPlatform

        if (platform !== null) {
            devicesListContainer.refresh(platform);
            cancelEditing()
            refreshData()
        }
    }

    function refreshData() {
        platformName.text = platform.name
        enabledStatusLabel.text = platform.enabled
        locationText.text = platform.room
        idValue.text = platform.id
        ipValue.text = platform.ip
        portValue.text = platform.port
        firmwareValue.text = platform.firmwareVersion
    }

    Rectangle {
        id: containerPadding
        anchors.fill: parent
        anchors.margins: 20
        //color: _colors.uGreen

        UI.UForm {
            id: platformValidator
            controlsToValidate: [ platformNameTextBox ]

            onAfterValidate: {
                saveCancelPlatform.changeSaveButtonState(isValid)
            }
        }

        Rectangle {
            id: info

            anchors.top: parent.top
            anchors.left: parent.left

            width: parent.width
            height: 50

            color: _colors.uTransparent

            ULabel.Default {
                id: platformName

                anchors.top: parent.top
                anchors.left: parent.left

                visible: !isEditing

                text: ""

                font.pointSize: 24
                font.bold: true
                color: _colors.uBlack
            }

            UI.UButton {
                iconId: "pencil"
                iconSize: 22

                anchors.top: parent.top
                anchors.right: parent.right
                width: 30
                height: 30

                visible: !isEditing

                buttonTextColor: _colors.uGrey
                buttonColor: _colors.uTransparent
                buttonHoveredTextColor: _colors.uGreen
                buttonHoveredColor: _colors.uTransparent

                onClicked: {
                    startEditing()
                }
            }

            UI.UTextbox {
                id: platformNameTextBox

                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: saveCancelPlatform.left
                anchors.rightMargin: 15

                height: 30
                placeholderText: "Platform name"

                visible: isEditing

                function validate() {
                    return text !== ""
                }

                state: (validate() ? "SUCCESS" : "ERROR")
                onTextChanged: { platformValidator.validate() }
            }

            UI.USaveCancel {
                id: saveCancelPlatform

                visible: isEditing

                anchors.top: parent.top
                anchors.right: parent.right

                onSave: { saveEditing() }
                onCancel: { cancelEditing() }
            }
        }

        Rectangle {
            id: enabledLabel
            anchors.top: info.bottom

            width: parent.width
            height: 30

            color: _colors.uTransparent

            ULabel.UInfoTitle {
                id: enabledTitle
                text: "Enabled"
            }

            ULabel.UInfoBoundedLabel {
                id: enabledStatusLabel
                text: "ON"

                anchors.left: enabledTitle.right
                anchors.verticalCenter: parent.verticalCenter

                visible: !isEditing
            }

            UI.USwitch {
                id: enabledSwitch
                state: platform.enabled

                anchors.left: enabledTitle.right
                anchors.verticalCenter: parent.verticalCenter

                visible: isEditing
            }
        }

        Rectangle {
            id: locationLabel

            anchors.top: enabledLabel.bottom
            anchors.topMargin: 10

            width: parent.width; height: 30

            color: _colors.uTransparent

            ULabel.UInfoTitle {
                id: locationTitle
                text: "Location"
            }

            ULabel.UInfoLabel {
                id: locationText
                text: ""
                visible: !isEditing
                anchors.left: locationTitle.right
            }

            UI.UTextbox {
                id: locationTextbox
                anchors.left: locationTitle.right
                anchors.leftMargin: -1
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: 15

                height: 30

                visible: isEditing
                placeholderText: "Enter a location"
            }
        }

        Rectangle {
            id: advancedInformation

            anchors.top: locationLabel.bottom

            anchors.left: parent.left

            width: parent.width
            clip: true

            color: _colors.uTransparent

            Rectangle {
                id: idLabel

                anchors.top: advancedInformation.top
                anchors.topMargin: 10

                width: parent.width
                height: 30

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: idTitle
                    text: "Platform ID"
                }

                ULabel.UInfoLabel {
                    id: idValue
                    text: platform.id
                    anchors.left: idTitle.right
                }
            }

            Rectangle {
                id: ipLabel

                anchors.top: idLabel.bottom
                anchors.topMargin: 10

                width: parent.width
                height: 30

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: ipTitle
                    text: "IP Address"
                }

                ULabel.UInfoLabel {
                    id: ipValue
                    text: platform.ip
                    anchors.left: ipTitle.right
                }
            }

            Rectangle {
                id: portLabel

                anchors.top: ipLabel.bottom
                anchors.topMargin: 10

                width: parent.width
                height: 30

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: portTitle
                    text: "Port Number"
                }

                ULabel.UInfoLabel {
                    id: portValue
                    text: platform.port
                    anchors.left: portTitle.right
                }
            }

            Rectangle {
                id: firmwareLabel

                anchors.top: portLabel.bottom
                anchors.topMargin: 10

                width: parent.width
                height: 30

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: firmwareTitle
                    text: "Firmware Version"
                }

                ULabel.UInfoLabel {
                    id: firmwareValue
                    text: platform.firmwareVersion
                    anchors.left: firmwareTitle.right
                }
            }
        }

        Rectangle {
            id: bottomLine

            width: parent.width
            height: 1

            anchors.left: parent.left

            anchors.top: advancedInformation.bottom
            anchors.topMargin: 20

            color: _colors.uLightGrey
        }

        UDeviceList {
            id: devicesListContainer

            anchors.top: bottomLine.bottom

            anchors.bottom: parent.bottom

            anchors.left: parent.left

            width: parent.width;
        }

        UI.UButton {
            id: showAdvancedInfo

            anchors.left: parent.left
            anchors.bottom: parent.bottom

            width: 210
            height: 30

            text: "Show advanced information"

            iconId: "info2"
            iconSize: 12

            buttonColor: _colors.uUltraLightGrey
            buttonTextColor: _colors.uGrey
            buttonHoveredColor: _colors.uUltraLightGrey

            onClicked: {
                if(container.state === "HideAdvanced") {
                    container.state = "ShowAdvanced"
                    showAdvancedInfo.changeText("Hide advanced information")
                } else {
                    container.state = "HideAdvanced"
                    showAdvancedInfo.changeText("Show advanced information")
                }
            }
        }
    }
}
