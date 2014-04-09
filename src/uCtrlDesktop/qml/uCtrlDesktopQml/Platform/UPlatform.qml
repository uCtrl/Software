import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property var platform: {"enabled": "ON", "name": "UNKNOWN", "room": "UNKNOWN", "ip": "255.255.255.255", "id": 0, "port": 0}
    property bool isEditing : false

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
    }

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

            anchors.verticalCenter: parent.verticalCenter

            anchors.left: parent.left
            anchors.leftMargin: 15

            visible: !isEditing

            text: ""

            font.pointSize: 24
            font.bold: true
            color: _colors.uBlack
        }

        UI.UButton {
            iconId: "Pencil"
            iconSize: 24

            anchors.right: parent.right
            anchors.rightMargin: 15
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
            id: platformNameTextBox

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.right: saveCancelPlatform.left
            anchors.rightMargin: 15

            height: 30
            placeholderText: "Enter a platform name"

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

            anchors.right: parent.right
            anchors.rightMargin: 15

            anchors.verticalCenter: parent.verticalCenter
            onSave: { saveEditing() }
            onCancel: { cancelEditing() }
        }
    }

    Rectangle {
        id: enabledLabel
        anchors.top: container.top
        anchors.topMargin: (platformName.height + 15)

        width: parent.width; height: 30

        color: _colors.uTransparent

        ULabel.Default {
            id: enabledTitle
            text: "Enabled"

            width: 100

            anchors.left: parent.left
            anchors.leftMargin: 15

            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 16
            font.bold: true
            color: _colors.uGrey
        }

        ULabel.Default {
            id: enabledStatusLabel
            text: "ON"

            anchors.left: enabledTitle.right
            anchors.verticalCenter: parent.verticalCenter

            visible: !isEditing

            font.pointSize: 16
            font.bold: true
            color: _colors.uGreen
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
        anchors.topMargin: 5

        width: parent.width; height: 30

        color: _colors.uTransparent

        ULabel.Default {
            id: locationTitle
            text: "Location"

            width: 100

            anchors.left: parent.left
            anchors.leftMargin: 15

            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 16
            font.bold: true
            color: _colors.uGrey
        }

        ULabel.Default {
            id: locationText

            text: ""

            visible: !isEditing

            anchors.left: locationTitle.right
            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 16
            font.bold: true
            color: _colors.uGreen
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
        id: networkInformation

        width: parent.width
        height: 30

        anchors.top: locationLabel.bottom
        anchors.topMargin: 5

        UI.UFontAwesome {
            id: networkIcon

            anchors.left: parent.left
            anchors.leftMargin: 25

            iconId: "Globe"
            iconSize: 16
            iconColor: _colors.uMediumLightGrey

            anchors.verticalCenter: parent.verticalCenter
        }

        ULabel.Default {
            id: showMoreInformation

            visible: true

            text: updateText()

            anchors.verticalCenter: parent.verticalCenter

            anchors.left: networkIcon.right
            anchors.leftMargin: 15

            color: _colors.uGrey

            font.pointSize: 12

            function updateText() {
                text = (advancedInformation.visible ? "Hide network information" : "Show network information")
            }
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                advancedInformation.visible = !advancedInformation.visible;
                showMoreInformation.updateText();
            }
        }
    }

    Rectangle {
        id: advancedInformation

        anchors.top: networkInformation.bottom
        anchors.topMargin: 5

        anchors.left: parent.left

        width: parent.width
        height: (visible ? 110 : 0)

        visible: false

        color: _colors.uTransparent

        Rectangle {
            id: ipLabel

            anchors.top: advancedInformation.top

            width: parent.width; height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: ipTitle
                text: "IP Adress"

                width: 100

                anchors.left: parent.left
                anchors.leftMargin: 15

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGrey
            }

            ULabel.Default {
                id: ipValue

                text: platform.ip

                anchors.left: ipTitle.right
                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGreen
            }
        }

        Rectangle {
            id: idLabel

            anchors.top: ipLabel.bottom
            anchors.topMargin: 4

            width: parent.width; height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: idTitle
                text: "Identifier"
                width: 100
                anchors.left: parent.left
                anchors.leftMargin: 15

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGrey
            }

            ULabel.Default {
                id: idValue

                text: platform.id

                anchors.left: idTitle.right
                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGreen
            }
        }

        Rectangle {
            id: portLabel

            anchors.top: idLabel.bottom
            anchors.topMargin: 4

            width: (parent.width / 4); height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: portTitle
                text: "Port"
                width: 100
                anchors.left: parent.left
                anchors.leftMargin: 15

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGrey
            }

            ULabel.Default {
                id: portValue

                text: platform.port
                anchors.left: portTitle.right
                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGreen
            }
        }
    }

    Rectangle {
        id: bottomLine

        property int marginSize: 3

        width: parent.width - (marginSize *2)
        height: 1

        anchors.left: parent.left
        anchors.leftMargin: marginSize

        anchors.top: advancedInformation.bottom
        anchors.topMargin: 10

        color: _colors.uLightGrey
    }

    UDeviceList {
        id: devicesListContainer

        anchors.top: bottomLine.bottom
        anchors.topMargin: 4

        anchors.bottom: parent.bottom

        anchors.left: parent.left

        width: parent.width;
    }
    /*
    UI.UForm {
        id: form

        property var model: container.model

        visible: false

        anchors.fill: parent

        color: _colors.uTransparent

        onIsValidChanged: editFrame.refresh()

        signal triggered;
        onTriggered: {
            form.validate()

            if (!visible) visible = true
            else {
                if (isValid) {
                    saveModel();
                    visible = !visible
                } else {
                    // @TODO : Display error.
                    console.log("Invalid form.");
                    state = "ERROR";
                }
            }
        }

        function refresh(newPlatform) {
            model = newPlatform;
            refreshChildren();
        }

        function saveModel() {
            container.platform.name = inputName.text;
            container.platform.room = inputRoom.text;
            container.platform.enabled = enabledSwitch.state;

            container.refresh(platform);
            systemFrame.notify();
        }

        // Form Objects
        UI.UTextbox {
            id: inputName

            property bool isValid: (text !== "")

            width: (form.width - (editFrame.width + 38)); height: 35

            anchors.top: form.top
            anchors.topMargin: 15

            anchors.left: form.left
            anchors.leftMargin: 12

            placeholderText: "Enter a name"

            state: (isValid ? "SUCCESS" : "ERROR")

            onTextChanged: {
                isValid = (text !== "")

                if (!isValid) form.isValid = false
                else form.validate()

                editFrame.refresh()
            }

            function refresh() { text = form.model.name; }
        }

        UI.USwitch {
            id: enabledSwitch

            anchors.top: inputName.bottom
            anchors.topMargin: 3

            anchors.left: form.left
            anchors.leftMargin: ((parent.width / 4) + 5);

            function refresh() { state = form.model.enabled; }
        }

        UI.UTextbox {
            id: inputRoom

            anchors.top: enabledSwitch.bottom
            anchors.topMargin: 5

            anchors.left: enabledSwitch.left
            anchors.leftMargin: -2

            anchors.right: inputName.right
            anchors.rightMargin: 0

            function refresh() { text = form.model.room; }
        }
    }
    */
}
