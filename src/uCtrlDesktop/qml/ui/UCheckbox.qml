import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: checkbox

    property string text: ""
    property bool checked: false
    state: "ENABLED"
    width: checkContainer.width + (text === "" ? 0 : (checkboxLabel.width + 5))
    height: 20

    property color checkedLabelColor : Colors.uBlack
    property color checkedIconColor : Colors.uBlack
    property color checkedContainerColor: Colors.uWhite
    property color checkedContainerBorderColor: Colors.uBlack

    property color uncheckedLabelColor : Colors.uBlack
    property color uncheckedIconColor : Colors.uBlack
    property color uncheckedContainerColor: Colors.uWhite
    property color uncheckedContainerBorderColor: Colors.uBlack

    Rectangle {
        id: checkContainer
        width: parent.height
        height: parent.height
        radius: 3
        border.width: 1

        UFontAwesome {
            id: checkBoxIcon
            visible: checkbox.checked
            iconId: "Ok"
            anchors.centerIn: parent
            iconSize: 12
        }
    }

    ULabel.Default {
        id: checkboxLabel
        text: checkbox.text
        anchors.left: checkContainer.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        anchors.fill: parent
        onReleased: {
            if (checkbox.state != "DISABLED") {
                checkbox.checked = !checkbox.checked
            }
        }
    }

    states: [
        State {
            name: "ENABLED"
            PropertyChanges { target: checkboxLabel; color: (checkbox.checked ? checkedLabelColor : uncheckedLabelColor) }
            PropertyChanges { target: checkboxLabel; font.bold: false }
            PropertyChanges { target: checkBoxIcon; iconColor: (checkbox.checked ? checkedIconColor : uncheckedIconColor) }
            PropertyChanges { target: checkContainer; color: (checkbox.checked ? checkedContainerColor : uncheckedContainerColor) }
            PropertyChanges { target: checkContainer; border.color: (checkbox.checked ? checkedContainerBorderColor : uncheckedContainerBorderColor) }
        },
        State {
            name: "DISABLED"
            PropertyChanges { target: checkboxLabel; color: Colors.uDarkGrey }
            PropertyChanges { target: checkboxLabel; font.bold: false }
            PropertyChanges { target: checkBoxIcon; iconColor: Colors.uDarkGrey }
            PropertyChanges { target: checkContainer; color: Colors.uLightGrey }
            PropertyChanges { target: checkContainer; border.color: Colors.uGrey }
        },
        State {
            name: "ERROR"
            PropertyChanges { target: checkboxLabel; color: Colors.uDarkRed }
            PropertyChanges { target: checkboxLabel; font.bold: true }
            PropertyChanges { target: checkBoxIcon; iconColor: Colors.uDarkRed }
            PropertyChanges { target: checkContainer; color: Colors.uWhite }
            PropertyChanges { target: checkContainer; border.color: Colors.uDarkRed }
        },
        State {
            name: "SUCCESS"
            PropertyChanges { target: checkboxLabel; color: Colors.uGreen }
            PropertyChanges { target: checkboxLabel; font.bold: false }
            PropertyChanges { target: checkBoxIcon; iconColor: Colors.uGreen }
            PropertyChanges { target: checkContainer; color: Colors.uWhite }
            PropertyChanges { target: checkContainer; border.color: Colors.uGreen }
        }
    ]
}
