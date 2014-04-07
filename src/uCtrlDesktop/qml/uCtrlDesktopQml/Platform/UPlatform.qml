import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property var platform: {"name": "UNKNOWN", "room": "UNKNOWN", "ip": "255.255.255.255", "id": 0, "port": 0}

    function refresh(newPlatform) {
        platform = newPlatform
        if (platform !== null) {
            devicesListContainer.refresh(platform);
            form.refresh(platform);
            refreshLabel()
        }
    }

    function refreshLabel() {
        locationText.text = platform.room;
        platformName.text = platform.name;
        ipValue.text = platform.ip;
        idValue.text = platform.id;
        portValue.text = platform.port;
        enabledStatusLabel.text = platform.enabled;
    }

    function hideForm() {
        form.visible = false
    }

    Rectangle {
        id: enabledLabel
        anchors.top: container.top
        anchors.topMargin: (platformName.height + 15)

        width: (parent.width / 4); height: 30

        color: _colors.uTransparent

        ULabel.Default {

            text: "Enabled"

            anchors.left: parent.left
            anchors.leftMargin: 15

            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 16
            font.bold: true
            color: _colors.uGrey
        }
    }

    Rectangle {
        id: locationLabel

        anchors.top: enabledLabel.bottom
        anchors.topMargin: 5

        width: (parent.width / 4); height: 30

        color: _colors.uTransparent

        ULabel.Default {

            text: "Location"

            anchors.left: parent.left
            anchors.leftMargin: 15

            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 16
            font.bold: true
            color: _colors.uGrey
        }
    }

    Rectangle {
        id: info

        visible: (!form.visible)

        anchors.top: container.top
        anchors.left: container.left
        anchors.right: container.right

        height: (container.height / 4)

        color: _colors.uTransparent

        ULabel.Default {
            id: platformName

            anchors.top: parent.top
            anchors.topMargin: 13

            anchors.left: parent.left
            anchors.leftMargin: 15

            text: ""

            font.pointSize: 32
            font.bold: true
            color: _colors.uBlack
        }

        Rectangle {
            id: enabledStatus
            anchors.top: platformName.bottom

            anchors.left: parent.left
            anchors.leftMargin: (enabledLabel.width + 10)

            width: (((parent.width / 4) * 3) - 5); height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: enabledStatusLabel
                text: "ON"

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGreen
            }
        }

        Rectangle {
            id: locationStatus
            anchors.top: enabledStatus.bottom

            anchors.left: parent.left
            anchors.leftMargin: (locationLabel.width + 10)

            width: (((parent.width / 4) * 3) - 5); height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: locationText

                text: ""

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGreen
            }
        }
    }

    UI.UFontAwesome {
        id: networkIcon

        iconId: "Globe"
        iconSize: 16
        iconColor: _colors.uMediumLightGrey

        anchors.top: info.bottom

        anchors.left: container.left
        anchors.leftMargin: 25

        opacity: 0.8
    }

    ULabel.Default {
        id: showMoreInformations

        visible: true

        text: updateText()

        anchors.top: networkIcon.top
        anchors.topMargin: -5

        anchors.left: networkIcon.right
        anchors.leftMargin: 10

        color: _colors.uGrey

        font.pointSize: 12

        opacity: 0.8

        function updateText() {
            text = (advancedInformation.visible ? "Hide network information" : "Show network information")
        }

        MouseArea {
            anchors.fill: parent;
            onClicked: {
                advancedInformation.visible = !advancedInformation.visible;
                showMoreInformations.updateText();
            }
        }
    }



    Rectangle {
        id: advancedInformation

        anchors.top: showMoreInformations.bottom
        anchors.topMargin: 5

        anchors.left: parent.left

        width: parent.width; height: 110;

        visible: false

        color: _colors.uTransparent

        Rectangle {
            id: ipLabel

            anchors.top: advancedInformation.top

            width: (parent.width / 4); height: 30

            color: _colors.uTransparent

            ULabel.Default {

                text: "IP Adress"

                anchors.left: parent.left
                anchors.leftMargin: 15

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGrey
            }
        }

        Rectangle {
            id: ipContainer
            anchors.top: ipLabel.top

            anchors.left: parent.left
            anchors.leftMargin: (enabledLabel.width + 10)

            width: (((parent.width / 4) * 3) - 5); height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: ipValue

                text: platform.ip

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

            width: (parent.width / 4); height: 30

            color: _colors.uTransparent

            ULabel.Default {

                text: "Identifier"

                anchors.left: parent.left
                anchors.leftMargin: 15

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGrey
            }
        }

        Rectangle {
            id: idContainer
            anchors.top: idLabel.top

            anchors.left: parent.left
            anchors.leftMargin: (enabledLabel.width + 10)

            width: (((parent.width / 4) * 3) - 5); height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: idValue

                text: platform.id

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

                text: "Port"

                anchors.left: parent.left
                anchors.leftMargin: 15

                anchors.verticalCenter: parent.verticalCenter

                font.pointSize: 16
                font.bold: true
                color: _colors.uGrey
            }
        }

        Rectangle {
            id: portContainer
            anchors.top: portLabel.top

            anchors.left: parent.left
            anchors.leftMargin: (enabledLabel.width + 10)

            width: (((parent.width / 4) * 3) - 5); height: 30

            color: _colors.uTransparent

            ULabel.Default {
                id: portValue

                text: platform.port

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

        anchors.top: (form.visible ? container.bottom : (advancedInformation.visible ? advancedInformation.bottom : showMoreInformations.bottom))
        anchors.topMargin: 20

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

    Rectangle {
        id: editFrame

        width: 40; height: 40

        radius: 5

        anchors.top: container.top
        anchors.topMargin: 20

        anchors.right: container.right
        anchors.rightMargin: 15

        color: _colors.uTransparent

        function refresh() {
            if (form.visible)
                color = (form.isValid ? _colors.uTransparent : _colors.uDarkRed)
            else
                color = _colors.uTransparent
        }

        UI.UFontAwesome {
            id: editButton

            anchors.centerIn: parent

            iconId: "Pencil"
            iconSize: 32
            iconColor: _colors.uGrey

            visible: (!form.visible)
        }

        UI.UFontAwesome {
            id: saveButton

            anchors.centerIn: parent

            iconId: "Save"
            iconSize: 32
            iconColor: (form.isValid ? _colors.uGreen : _colors.uWhite)

            visible: (form.visible)
        }
    }

    UI.UToolTip {
        id: editTooltip

        visible: false

        anchors.verticalCenter: editFrame.verticalCenter

        anchors.right: editFrame.left
        anchors.rightMargin: 10

        text: (form.visible ? "Save" : "Edit")
        width: 75

        arrowRight: true
    }

    MouseArea {
        id: editArea

        anchors.fill: editFrame
        hoverEnabled: true

        onEntered: editTooltip.startAnimation()
        onExited: editTooltip.stopAnimation()

        onClicked: { form.triggered() }
    }
}
