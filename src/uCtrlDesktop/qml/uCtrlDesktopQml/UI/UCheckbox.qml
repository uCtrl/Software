import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../UI/ULabel" as ULabel

Rectangle {
    id: checkbox

    property string text: ""
    property bool checked: false
    state: "ENABLED"
    width: checkContainer.width + (text === "" ? 0 : (checkboxLabel.width + 5))
    height: 20

    property color checkedLabelColor : _colors.uBlack
    property color checkedIconColor : _colors.uBlack
    property color checkedContainerColor: _colors.uWhite
    property color checkedContainerBorderColor: _colors.uBlack

    property color uncheckedLabelColor : _colors.uBlack
    property color uncheckedIconColor : _colors.uBlack
    property color uncheckedContainerColor: _colors.uWhite
    property color uncheckedContainerBorderColor: _colors.uBlack

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
            PropertyChanges { target: checkboxLabel; color: _colors.uDarkGrey }
            PropertyChanges { target: checkboxLabel; font.bold: false }
            PropertyChanges { target: checkBoxIcon; iconColor: _colors.uDarkGrey }
            PropertyChanges { target: checkContainer; color: _colors.uLightGrey }
            PropertyChanges { target: checkContainer; border.color: _colors.uGrey }
        },
        State {
            name: "ERROR"
            PropertyChanges { target: checkboxLabel; color: _colors.uDarkRed }
            PropertyChanges { target: checkboxLabel; font.bold: true }
            PropertyChanges { target: checkBoxIcon; iconColor: _colors.uDarkRed }
            PropertyChanges { target: checkContainer; color: _colors.uWhite }
            PropertyChanges { target: checkContainer; border.color: _colors.uDarkRed }
        },
        State {
            name: "SUCCESS"
            PropertyChanges { target: checkboxLabel; color: _colors.uGreen }
            PropertyChanges { target: checkboxLabel; font.bold: false }
            PropertyChanges { target: checkBoxIcon; iconColor: _colors.uGreen }
            PropertyChanges { target: checkContainer; color: _colors.uWhite }
            PropertyChanges { target: checkContainer; border.color: _colors.uGreen }
        }
    ]
}
