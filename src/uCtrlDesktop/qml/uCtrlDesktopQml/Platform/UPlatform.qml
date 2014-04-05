import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property var platform: {"name": "UNKNOWN", "room": "UNKNOWN"}

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
    }

    function hideForm() {
        form.visible = false
    }

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
        id: enabledLabel
        anchors.top: platformName.bottom

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

    // @TODO : Replace with uSwitch
    Rectangle {
        id: enabledStatus
        anchors.top: enabledLabel.top

        anchors.left: enabledLabel.right
        anchors.leftMargin: 5

        width: (((parent.width / 4) * 3) - 5); height: 30

        color: _colors.uTransparent

        ULabel.Default {

            text: "ON"

            anchors.verticalCenter: parent.verticalCenter

            font.pointSize: 16
            font.bold: true
            color: _colors.uGreen
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
        id: locationStatus
        anchors.top: locationLabel.top

        anchors.left: locationLabel.right
        anchors.leftMargin: 5

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

    Rectangle {
        property int marginSize: 3

        id: bottomLine

        width: parent.width - (marginSize *2)
        height: 1

        anchors.left: parent.left
        anchors.leftMargin: marginSize

        anchors.top: (form.visible ? container.bottom : locationLabel.bottom)
        anchors.topMargin: 20

        color: _colors.uLightGrey
    }

    UI.ULabel {
        id: listIntro

        text: "Platform's devices list"

        anchors.top: bottomLine.bottom
        anchors.topMargin: 15

        anchors.horizontalCenter: parent.horizontalCenter

        headerStyle: 0
        Component.onCompleted: {
            font.pixelSize = 16
            font.underline = true
            color = _colors.uGrey
        }
    }

    UDeviceList {
       id: devicesListContainer

       anchors.top: listIntro.bottom
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

        state: (validate() ? "SUCCESS" : "ERROR")

        signal triggered;
        onTriggered: {
            if (validate()) {
                visible = !visible;
                state = "SUCCESS";
                saveModel();

                container.refresh(platform);
                systemFrame.notify();
            } else {
                // @TODO : Display error.
                console.log("Invalid form.");
                state = "ERROR";
            }
        }

        function refresh(newPlatform) {
            model = newPlatform
            refreshChildrens();
        }

        function saveModel() {
            container.platform.setName(inputName.text);
            container.platform.setRoom(inputRoom.text);
        }

        // Form Objects
        UI.UTextbox {
            id: inputName

            width: (form.width - (editFrame.width + 38)); height: 35

            anchors.top: form.top
            anchors.topMargin: 15

            anchors.left: form.left
            anchors.leftMargin: 12

            placeholderText: "Enter a name"

            state: (validate() ? "SUCCESS" : "ERROR")

            function validate() { return (text !== ""); }
            function refresh() { text = form.model.name; }
        }

        UI.USwitch {
            id: enabledSwitch

            anchors.top: inputName.bottom
            anchors.topMargin: 3

            anchors.left: form.left
            anchors.leftMargin: ((parent.width / 4) + 5);

            function validate() { return true; }
            function refresh() { state = "ON"; }
        }

        UI.UTextbox {
            id: inputRoom

            anchors.top: enabledSwitch.bottom
            anchors.topMargin: 5

            anchors.left: enabledSwitch.left
            anchors.leftMargin: -2

            anchors.right: inputName.right
            anchors.rightMargin: 0

            function validate() { return true; }
            function refresh() { text = form.model.room; }
        }
    }

    Rectangle {
        id: editFrame

        width: 40; height: 40

        radius: 5

        anchors.right: container.right
        anchors.rightMargin: 15

        anchors.verticalCenter: platformName.verticalCenter

        color: getFrameColor()

        function getFrameColor() {
            if (form.visible)
                return (form.state === "ERROR" ? _colors.uDarkRed : _colors.uTransparent)
            else
                return _colors.uTransparent
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
            iconColor: (form.state === "ERROR" ? _colors.uWhite : _colors.uGreen)

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

        onHoveredChanged: {
            if (containsMouse)
                editTooltip.startAnimation()
            else
                editTooltip.stopAnimation()

        }

        onClicked: { form.triggered() }
    }
}
