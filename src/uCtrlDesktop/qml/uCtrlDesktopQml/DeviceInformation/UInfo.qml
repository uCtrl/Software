import QtQuick 2.0

import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: infoTab
    anchors.fill: parent

    color: _colors.uTransparent

    property var deviceInfoModel: {"enabled": "UNKNOWN", status: "UNKNOWN", "id": "UNKNOWN", "name": "UNKNOWN", "minValue": "UNKNOWN", "maxValue": "UNKNOWN", "precision": "UNKNOWN", "unitLabel": "UNIT", "description": "Something went terribly wrong. We must apologize"}
    property bool isEditing : false

    property int animationTime: 500

    state: "HideAdvanced"

    states: [
        State {
            name: "ShowAdvanced"
            PropertyChanges { target: advancedInfoBlock; height: 40 * 5 }
        },
        State {
            name: "HideAdvanced"
            PropertyChanges { target: advancedInfoBlock; height: 0 }
        }
    ]

    transitions: [
        Transition {
            PropertyAnimation { target: advancedInfoBlock; duration: animationTime; property: "height"; easing.type: Easing.InOutQuad }
        }
    ]

    function refresh(newDevice) {
        deviceInfoModel = newDevice
        refreshData()
    }

    function refreshData() {
        enabledLabel.changeText(deviceInfoModel.enabled)
        statusLabel.changeText(deviceInfoModel.status + " " + deviceInfoModel.unitLabel)
        idLabel.text = deviceInfoModel.id
        deviceName.text = deviceInfoModel.name
        minValueLabel.text = deviceInfoModel.minValue
        maxValueLabel.text = deviceInfoModel.maxValue
        precisionLabel.text = deviceInfoModel.precision
        unitLabelLabel.text = deviceInfoModel.unitLabel
        descriptionLabel.text = deviceInfoModel.description
    }

    function saveData() {
        deviceInfoModel.enabled = enabledSwitch.state
        deviceInfoModel.name = deviceNameTextbox.text

        deviceInfoModel.minValue = minValueTextbox.text
        deviceInfoModel.maxValue = maxValueTextbox.text
        deviceInfoModel.precision = precisionTextbox.text
        deviceInfoModel.unitLabel = unitLabelTextbox.text
        deviceInfoModel.description = descriptionTextbox.text

        refreshData()

        isEditing = false
    }

    function startEditing() {
        isEditing = true

        enabledSwitch.state = deviceInfoModel.enabled
        deviceNameTextbox.text = deviceInfoModel.name

        minValueTextbox.text = deviceInfoModel.minValue
        maxValueTextbox.text = deviceInfoModel.maxValue
        precisionTextbox.text = deviceInfoModel.precision
        unitLabelTextbox.text = deviceInfoModel.unitLabel
        descriptionTextbox.text = deviceInfoModel.description
    }

    function cancelEditing() {
        isEditing = false
    }

    Rectangle {
        id: header
        width: parent.width
        height: 50

        color: _colors.uTransparent

        Rectangle {
            id: deviceIconContainer
            width: parent.height
            height: parent.height
            radius: 5

            visible: !isEditing

            color: _colors.uGreen
        }

        ULabel.Default {
            id: deviceName

            anchors.verticalCenter: parent.verticalCenter

            anchors.left: deviceIconContainer.right
            anchors.leftMargin: 15

            visible: !isEditing

            text: deviceInfoModel.name

            font.pointSize: 24
            font.bold: true
            color: _colors.uBlack
        }

        UI.UButton {
            iconId: "Pencil"
            iconSize: 24

            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            width: 30
            height: 30

            visible: !isEditing

            buttonTextColor: _colors.uBlack
            buttonColor: _colors.uTransparent
            buttonHoveredColor: _colors.uGrey

            onClicked: {
                startEditing()
            }
        }

        UI.UTextbox {
            id: deviceNameTextbox

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: saveCancelButton.left
            anchors.rightMargin: 15
            height: 30

            visible: isEditing

            placeholderText: "Enter a device name"

            state: (validate() ? "SUCCESS" : "ERROR")
            onTextChanged: infoForm.validate()
            function validate() { return text !== "" }
        }

        UI.USaveCancel {
            id: saveCancelButton
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            height: 30

            visible: isEditing

            onSave: {
                saveData()
            }

            onCancel: {
                cancelEditing()
            }
        }
    }

    Rectangle {
        id: content

        width: parent.width
        anchors.top: header.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom

        color: _colors.uTransparent

        Rectangle {
            id: enabledRow
            width: parent.width
            height: 30

            color: _colors.uTransparent

            ULabel.UInfoTitle {
                id: enabledTitle
                text: "Enabled"
            }

            ULabel.UInfoBoundedLabel {
                id: enabledLabel
                text: deviceInfoModel.enabled

                anchors.left: enabledTitle.right
                visible: !isEditing
            }

            UI.USwitch {
                id: enabledSwitch

                visible: isEditing

                anchors.left: enabledTitle.right
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Rectangle {
            id: statusRow
            width: parent.width
            height: 30

            anchors.top: enabledRow.bottom
            anchors.topMargin: 10

            color: _colors.uTransparent

            ULabel.UInfoTitle {
                id: statusTitle
                text: "Status"
            }

            ULabel.UInfoBoundedLabel {
                id: statusLabel
                text: deviceInfoModel.status + " " + deviceInfoModel.unitLabel

                anchors.left: statusTitle.right
            }
        }

        Rectangle {
            id: advancedInfoBlock
            clip: true
            width: parent.width
            height: 40 * 5

            anchors.top: statusRow.bottom

            color: _colors.uTransparent

            Rectangle {
                id: idRow
                width: parent.width
                height: 30

                anchors.top: parent.top
                anchors.topMargin: 10

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: idTitle
                    text: "Id"
                }

                ULabel.UInfoLabel {
                    id: idLabel
                    text: deviceInfoModel.id

                    anchors.left: idTitle.right
                }
            }

            Rectangle {
                id: minValueRow
                width: parent.width
                height: 30

                anchors.top: idRow.bottom
                anchors.topMargin: 10

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: minValueTitle
                    text: "Min. value"
                }

                ULabel.UInfoLabel {
                    id: minValueLabel
                    text: deviceInfoModel.minValue

                    anchors.left: minValueTitle.right

                    visible: !isEditing
                }

                UI.UTextbox {
                    id: minValueTextbox
                    placeholderText: "Enter a minimal value"

                    anchors.left: minValueTitle.right
                    anchors.right: parent.right

                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                    visible: isEditing

                    state: (validate() ? "SUCCESS" : "ERROR")
                    onTextChanged: infoForm.validate()
                    function validate() {
                        if(text === "")
                            return false

                        var val = parseFloat(text)
                        if(isNaN(val))
                            return false

                        return true
                    }
                }
            }

            Rectangle {
                id: maxValueRow
                width: parent.width
                height: 30

                anchors.top: minValueRow.bottom
                anchors.topMargin: 10

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: maxValueTitle
                    text: "Max. value"
                }

                ULabel.UInfoLabel {
                    id: maxValueLabel
                    text: deviceInfoModel.maxValue

                    anchors.left: maxValueTitle.right

                    visible: !isEditing
                }

                UI.UTextbox {
                    id: maxValueTextbox
                    placeholderText: "Enter a maximal value"

                    anchors.left: maxValueTitle.right
                    anchors.right: parent.right

                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                    visible: isEditing

                    state: (validate() ? "SUCCESS" : "ERROR")
                    onTextChanged: infoForm.validate()
                    function validate() {
                        if(text === "")
                            return false

                        var val = parseFloat(text)
                        if(isNaN(val))
                            return false

                        return true
                    }
                }
            }

            Rectangle {
                id: precisionRow
                width: parent.width
                height: 30

                anchors.top: maxValueRow.bottom
                anchors.topMargin: 10

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: precisionTitle
                    text: "Precision"
                }

                ULabel.UInfoLabel {
                    id: precisionLabel
                    text: deviceInfoModel.precision

                    anchors.left: precisionTitle.right

                    visible: !isEditing
                }

                UI.UTextbox {
                    id: precisionTextbox
                    placeholderText: "Enter a precision"

                    anchors.left: precisionTitle.right
                    anchors.right: parent.right

                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                    visible: isEditing

                    state: (validate() ? "SUCCESS" : "ERROR")
                    onTextChanged: infoForm.validate()
                    function validate() {
                        if(text === "")
                            return false

                        var val = parseInt(text)
                        if(isNaN(val))
                            return false

                        return val >= 0
                    }
                }
            }

            Rectangle {
                id: unitLabelRow
                width: parent.width
                height: 30

                anchors.top: precisionRow.bottom
                anchors.topMargin: 10

                color: _colors.uTransparent

                ULabel.UInfoTitle {
                    id: unitLabelTitle
                    text: "Units"
                }

                ULabel.UInfoLabel {
                    id: unitLabelLabel
                    text: deviceInfoModel.unitLabel

                    anchors.left: unitLabelTitle.right

                    visible: !isEditing
                }

                UI.UTextbox {
                    id: unitLabelTextbox
                    placeholderText: "Enter the units used by this device"

                    anchors.left: unitLabelTitle.right
                    anchors.right: parent.right

                    height: 30
                    anchors.verticalCenter: parent.verticalCenter

                    visible: isEditing

                    state: (validate() ? "SUCCESS" : "ERROR")
                    onTextChanged: infoForm.validate()
                    function validate() { return text !== "" }
                }
            }
        }

        Rectangle {
            id: descriptionRow
            width: parent.width
            height: 30

            anchors.top: advancedInfoBlock.bottom
            anchors.topMargin: 10

            color: _colors.uTransparent

            clip: false

            ULabel.UInfoTitle {
                id: descriptionTitle
                text: "Description"
            }

            ULabel.UInfoLabel {
                id: descriptionLabel
                text: deviceInfoModel.description

                horizontalAlignment: Text.AlignJustify
                anchors.top: parent.top
                anchors.left: descriptionTitle.right
                anchors.right: parent.right
                anchors.rightMargin: 35

                visible: !isEditing
            }

            UI.UTextbox {
                id: descriptionTextbox
                placeholderText: "Enter a description"

                anchors.left: descriptionTitle.right
                anchors.right: parent.right

                height: 30
                anchors.verticalCenter: parent.verticalCenter

                visible: isEditing
            }
        }

        UI.UForm {
            id: infoForm

            controlsToValidate: [ deviceNameTextbox, minValueTextbox, maxValueTextbox, precisionTextbox, unitLabelTextbox ]

            onAfterValidate: {
                saveCancelButton.changeSaveButtonState(isValid)
            }
        }

        UI.UButton {
            id: showAdvancedInfo

            anchors.left: parent.left
            anchors.bottom: parent.bottom

            width: 210
            height: 30

            text: "Show advanced information"

            iconId: "Globe"
            iconSize: 12

            buttonColor: _colors.uTransparent
            buttonTextColor: _colors.uGrey
            buttonHoveredColor: _colors.uTransparent

            onClicked: {
                if(infoTab.state === "HideAdvanced") {
                    infoTab.state = "ShowAdvanced"
                    showAdvancedInfo.changeText("Hide advanced information")
                } else {
                    infoTab.state = "HideAdvanced"
                    showAdvancedInfo.changeText("Show advanced information")
                }
            }
        }
    }
}
