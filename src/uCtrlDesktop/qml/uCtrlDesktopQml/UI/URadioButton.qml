import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

RadioButton {
    id: radiobutton
    anchors.margins: 4
    state: "ENABLED"

    style: RadioButtonStyle {
        indicator: UCircle {

            implicitHeight: 18
            implicitWidth: 18

            color: getBackgroundColor()
            border.color: getBorderColor()
            border.width: 1

            Rectangle {
                visible: control.checked
                color: getRoundColor()
                radius: 9
                anchors.fill: parent
                anchors.margins: 3
            }
        }

        label: Text{
            id: radiobuttonLabel
            font.bold: (radiobutton.state == "ERROR")
            text: control.text
            color: getTextColor()
        }
    }

    function getBackgroundColor() {
        switch(state){
            case "ENABLED":
                return _colors.uWhite
            case "DISABLED":
                return _colors.uLightGrey
            case "ERROR":
                return _colors.uWhite
            }
    }

    function getBorderColor() {
        switch(state){
        case "ENABLED":
            return _colors.uGreen
        case "DISABLED":
            return _colors.uLightGrey
        case "ERROR":
            return _colors.uDarkRed
        }
    }

    function getRoundColor() {
        switch(state){
        case "ENABLED":
            return _colors.uGreen
        case "DISABLED":
            return _colors.uLightGrey
        case "ERROR":
            return _colors.uWhite
        }
    }

    function getTextColor() {
        switch(state){
        case"ENABLED":
            return _colors.uGreen // en attendant de trouver du noir
        case"DISABLED":
            return _colors.uLightGrey
        case"ERROR":
            return _colors.uDarkRed
        }
    }



    function execute() {
        console.log(radiobutton.checked)
    }

    MouseArea {
        anchors.fill: parent
        onReleased: {
            if (radiobutton.state != "DISABLED") {
                checked = !checked
            } else {
                checked = checked
            }
        }

    }

    states: [
        State { name: "ENABLED" },
        State { name: "DISABLED" },
        State { name: "ERROR" }
    ]
}

