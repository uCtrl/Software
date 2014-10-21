import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../ui" as UI
import "UColors.js" as Colors

Rectangle {
    id: container

    property string placeholderText: ""
    property string text: ""

    property string iconId: ""
    property int iconSize: 8

    property int textAlignment: TextInput.AlignLeft

    width: 100
    height: 25

    color: Colors.get("uTransparent")

    state: "ENABLED"

    function getBackgroundColor() {
        switch (state) {
            case "DISABLED":
                return Colors.get("uLightGrey")
            default:
                return Colors.get("uWhite")
        }
    }

    function getBorderColor() {
        switch (state) {
            case "SUCCESS":
                return Colors.get("uGreen")
            case "ERROR":
                return Colors.get("uDarkRed")
            default:
                return Colors.get("uGrey")
        }
    }

    function getIconColor() {
        switch (state) {
            case "SUCCESS":
                return Colors.get("uGreen")
            case "ERROR":
                return Colors.get("uDarkRed")
            default:
                return Colors.get("uTransparent")
        }
    }

    function getTextColor() {
        switch (state) {
            case "ENABLED":
                return Colors.get("uBlack")
            case "DISABLED":
                return Colors.get("uGrey")
            case "ERROR":
                return Colors.get("uDarkRed")
            case "SUCCESS":
                return Colors.get("uGreen")
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
            selectedTextColor: Colors.get("uWhite")
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
            iconColor: (container.state === "SUCCESS" || container.state === "ERROR" ? Colors.get("uWhite") : Colors.get("uGrey"))
        }
    }
}
