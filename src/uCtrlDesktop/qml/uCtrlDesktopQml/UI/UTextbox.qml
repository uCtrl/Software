import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

TextField {
    id: field

    state: "ENABLED"

    width: 100; height: 25

    anchors.margins: 4

    readOnly: (state === "DISABLED")

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

    function getBackgroundColor() {
        switch (state) {
            case "DISABLED":
                return _colors.uLightGrey
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
}
