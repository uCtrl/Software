import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: container

    property var platform: null
    property bool formVisible : false

    function refresh(newPlatform) {
        platform = newPlatform
        if (platform !== null) { devicesListContainer.refresh(platform) }
    }

    UI.ULabel {
        id: platformName

        anchors.top: parent.top
        anchors.topMargin: 13

        anchors.left: parent.left
        anchors.leftMargin: 15

        text: (platform !== null ? platform.name : "UNKNOWN")

        Component.onCompleted: {
            font.pointSize = 32
            font.bold = true
            color = _colors.uBlack
        }
    }

    Rectangle {
        id: editFrame

        width: 40; height: 40

        anchors.right: container.right
        anchors.rightMargin: 15

        anchors.verticalCenter: platformName.verticalCenter

        visible: !formVisible

        color: _colors.uTransparent

        UI.UFontAwesome {
            id: editButton

            anchors.centerIn: parent

            iconId: "Pencil"
            iconSize: 32
            iconColor: _colors.uGrey
        }
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

        onClicked: { formVisible = !formVisible }
    }

    UI.UToolTip {
        id: editTooltip

        visible: false

        anchors.verticalCenter: editFrame.verticalCenter

        anchors.right: editFrame.left
        anchors.rightMargin: 10

        text: "Edit"
        width: 75

        arrowRight: true
    }

    Rectangle {
        id: enabledLabel
        anchors.top: platformName.bottom

        width: (parent.width / 4); height: 30

        color: _colors.uTransparent

        UI.ULabel {

            text: "Enabled"

            anchors.left: parent.left
            anchors.leftMargin: 15

            anchors.verticalCenter: parent.verticalCenter

            headerStyle: 0
            Component.onCompleted: {
                font.pointSize = 16
                font.bold = true
                color = _colors.uGrey
            }
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

        UI.ULabel {

            text: "ON"

            anchors.verticalCenter: parent.verticalCenter

            headerStyle: 0
            Component.onCompleted: {
                font.pointSize = 16
                font.bold = true
                color = _colors.uGreen
            }
        }
    }

    Rectangle {
        id: locationLabel

        anchors.top: enabledLabel.bottom
        anchors.topMargin: 5

        width: (parent.width / 4); height: 30

        color: _colors.uTransparent

        UI.ULabel {

            text: "Location"

            anchors.left: parent.left
            anchors.leftMargin: 15

            anchors.verticalCenter: parent.verticalCenter

            headerStyle: 0
            Component.onCompleted: {
                font.pointSize = 16
                font.bold = true
                color = _colors.uGrey
            }
        }
    }

    // @TODO : Replace with uSwitch
    Rectangle {
        id: locationStatus
        anchors.top: locationLabel.top

        anchors.left: locationLabel.right
        anchors.leftMargin: 5

        width: (((parent.width / 4) * 3) - 5); height: 30

        color: _colors.uTransparent

        UI.ULabel {

            text: (container.platform !== null ? container.platform.room : "UNKNOWN")

            anchors.verticalCenter: parent.verticalCenter

            headerStyle: 0
            Component.onCompleted: {
                font.pointSize = 16
                font.bold = true
                color = _colors.uGreen
            }
        }
    }

    Rectangle {
        property int marginSize: 3

        id: bottomLine

        width: parent.width - (marginSize *2)
        height: 1

        anchors.left: parent.left
        anchors.leftMargin: marginSize

        anchors.top: (formVisible ? container.bottom : locationLabel.bottom)
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

    // @TODO : Replace with UForm container.
    Rectangle {
        id: form

        visible: container.formVisible

        anchors.fill: parent

        color: _colors.uDarkGrey

        opacity: 0.3
    }
}
