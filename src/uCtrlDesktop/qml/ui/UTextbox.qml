import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../ui" as UI

Rectangle {
    id: container

    property string placeholderText: ""
    property string text: ""

    property string iconId: ""
    property int iconSize: 8

    property int textAlignment: TextInput.AlignLeft

    width: 100
    height: 25

    color: "transparent"

    state: "ENABLED"

    function getBackgroundColor() {
        switch (state) {
            case "DISABLED":
                return "#EDEDED"
            default:
                return "white"
        }
    }

    function getBorderColor() {
        switch (state) {
            case "SUCCESS":
                return "#0D9B0D"
            case "ERROR":
                return "#A60E0E"
            default:
                return "#AAAAAA"
        }
    }

    function getIconColor() {
        switch (state) {
            case "SUCCESS":
                return "#0D9B0D"
            case "ERROR":
                return "#A60E0E"
            default:
                return "transparent"
        }
    }

    function getTextColor() {
        switch (state) {
            case "ENABLED":
                return "black"
            case "DISABLED":
                return "#AAAAAA"
            case "ERROR":
                return "#A60E0E"
            case "SUCCESS":
                return "#0D9B0D"
        }
    }

    TextField {
        id: field

        font.family: "Lato"

        state: parent.state
        readOnly: (state === "DISABLED")

        anchors.fill: parent

        text: parent.text
        placeholderText: parent.placeholderText

        horizontalAlignment: container.textAlignment
        verticalAlignment: Text.AlignVCenter

        style: TextFieldStyle {
            padding.left: 10
            padding.right: 10
            textColor: getTextColor()
            selectedTextColor: "white"
            selectionColor: getBorderColor()

            background: Rectangle {
                color: getBackgroundColor()
                radius: 2

                implicitWidth: field.width
                implicitHeight: field.height

                border.color: getBorderColor()
                border.width: 1
            }
        }

        Keys.onReleased: parent.text = text
    }

    onStateChanged: {
        icon.refresh(iconFrame.getIcon())
    }

    Rectangle {
        id: iconFrame

        width: 16; height: 16;
        radius: 9

        color: getIconColor()

        anchors.verticalCenter: container.verticalCenter

        anchors.right: field.right
        anchors.rightMargin: 6

        visible: (parent.iconId !== null || container.state === "SUCCESS" || container.state === "ERROR")

        function getIcon() {
            if (parent.state === "ERROR")
                return "Remove"
            else if (container.iconId !== "")
                return container.iconId
            else if(parent.state === "SUCCESS")
                return "Ok"
            else
                return ""
        }

        UI.UFontAwesome {
            id: icon

            anchors.centerIn: parent
            iconSize: container.iconSize
            iconColor: (container.state === "SUCCESS" || container.state === "ERROR" ? "white" : "#AAAAAA")
        }
    }
}
