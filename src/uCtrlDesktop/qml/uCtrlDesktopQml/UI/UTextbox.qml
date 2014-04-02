import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../UI" as UI

Rectangle {
    id: container

    property string placeholderText: ""
    property string text: ""

    property var fontAwesome: null
    property int iconSize: 10

    width: 100; height: 25
    anchors.margins: 4

    state: "ENABLED"

    function getBackgroundColor() {
        switch (state) {
            case "DISABLED":
                return _colors.uLightGrey
            default:
                return _colors.uWhite
        }
    }

    function getBorderColor() {
        switch (state) {
            case "SUCCESS":
                return _colors.uGreen
            case "ERROR":
                return _colors.uDarkRed
            default:
                return _colors.uGrey
        }
    }

    function getIconColor() {
        switch (state) {
            case "SUCCESS":
                return _colors.uGreen
            case "ERROR":
                return _colors.uDarkRed
            default:
                return _colors.uWhite
        }
    }

    function getTextColor() {
        switch (state) {
            case "ENABLED":
                return _colors.uBlack
            case "DISABLED":
                return _colors.uGrey
            case "ERROR":
                return _colors.uDarkRed
            case "SUCCESS":
                return _colors.uGreen
        }
    }

    TextField {
        id: field

        state: parent.state
        readOnly: (state === "DISABLED")

        width: parent.width; height: parent.height
        anchors.fill: parent

        placeholderText: parent.placeholderText

        style: TextFieldStyle {
            textColor: getTextColor()
            selectedTextColor: _colors.uWhite
            selectionColor: getBorderColor()

            background: Rectangle {
                color: getBackgroundColor()
                radius: 3

                implicitWidth: field.width
                implicitHeight: field.height

                border.color: getBorderColor()
                border.width: 1
            }
        }

        Keys.onReleased: parent.text = text
    }

    Rectangle {
        id: iconFrame

        width: 16; height: 16;
        radius: 9

        color: getIconColor()

        anchors.verticalCenter: container.verticalCenter

        anchors.right: field.right
        anchors.rightMargin: 4

        visible: (parent.fontAwesome !== null || parent.state === "SUCCESS" || parent.state === "ERROR")

        function getIcon() {
            if (parent.state === "ERROR")
                return "Remove"
            else if (parent.fontAwesome !== null)
                return parent.fontAwesome
            else
                return "Ok"
        }

        UI.UFontAwesome {
            id: icon

            anchors.centerIn: parent

            iconId: parent.getIcon()
            iconSize: container.iconSize
            iconColor: (container.state === "SUCCESS" || container.state === "ERROR" ? _colors.uWhite : _colors.uGrey)
        }
    }
}
