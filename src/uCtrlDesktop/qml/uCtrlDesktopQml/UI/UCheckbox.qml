import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

CheckBox {
    id: checkbox

    property string text: "UNKNOWN"
    state: "ENABLED"

    style: CheckBoxStyle {
        indicator: Rectangle {
            implicitWidth: 18
            implicitHeight: 18

            radius: 3

            color: getBackgroundColor()
            border.color: getBorderColor()
            border.width: 1

            UFontAwesome {
                visible: control.checked
                iconId: "Ok"
                iconColor: getCheckColor()
                anchors.centerIn: parent
                iconSize: 12
            }
        }

        label: Text {
            id: checkboxLabel
            font.bold: (checkbox.state === "ERROR")
            text: control.text
            color: getTextColor()
        }
    }

    function getBackgroundColor () {
        switch (state) {
            case "ENABLED":
                return (checked ? _colors.uGreen : _colors.uWhite)
            case "DISABLED":
                return _colors.uUltraLightGrey
            case "ERROR":
                return (checked ? _colors.uDarkRed : _colors.uWhite)
        }
    }

    function getBorderColor () {
        switch (state) {
            case "ENABLED":
                return _colors.uGreen
            case "DISABLED":
                return _colors.uUltraLightGrey
            case "ERROR":
                return _colors.uDarkRed
        }
    }

    function getCheckColor() {
        switch (state) {
            case "ENABLED":
                return _colors.uWhite
            case "DISABLED":
                return _colors.uGrey
            case "ERROR":
                return _colors.uWhite
        }
    }

    function getTextColor() {
        switch (state) {
            case "ENABLED":
                return _colors.uBlack
            case "DISABLED":
                return _colors.uDarkGrey
            case "ERROR":
                return _colors.uDarkRed
        }
    }

    MouseArea {
        anchors.fill: parent
        onReleased: {
            if (checkbox.state != "DISABLED") {
                checked = !checked
            } else {
                checked = checked
            }
        }
    }

    states: [
        State {
            name: "ENABLED"
        },
        State {
            name: "DISABLED"
        },
        State {
            name: "ERROR"
        }
    ]

    transitions: [
        Transition {
            ColorAnimation { from: _colors.uGreen; to: _colors.uLightGrey; duration: 75 }
        }
    ]
}
