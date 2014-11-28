import QtQuick 2.0

import "UColors.js" as Colors
import "../label" as ULabel

Rectangle {
    width: 200
    height: 30

    color: Colors.uTransparent

    Row
    {
        anchors.fill: parent
        spacing: 5

        Rectangle
        {
            id: sundayCheckbox

            property bool checked: false

            width: 30
            height: 30
            radius: 5

            color: checked ? Colors.uGreen : Colors.uLightGrey

            ULabel.Default
            {
                text: "S"
                color: parent.checked ? Colors.uWhite : Colors.uBlack
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: parent.checked = !parent.checked
            }
        }
        Rectangle
        {
            id: mondayCheckbox

            property bool checked: false

            width: 30
            height: 30
            radius: 5

            color: checked ? Colors.uGreen : Colors.uLightGrey

            ULabel.Default
            {
                text: "M"
                color: parent.checked ? Colors.uWhite : Colors.uBlack
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: parent.checked = !parent.checked
            }
        }
        Rectangle
        {
            id: tuesdayCheckbox

            property bool checked: false

            width: 30
            height: 30
            radius: 5

            color: checked ? Colors.uGreen : Colors.uLightGrey

            ULabel.Default
            {
                text: "T"
                color: parent.checked ? Colors.uWhite : Colors.uBlack
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: parent.checked = !parent.checked
            }
        }
        Rectangle
        {
            id: wednesdayCheckbox

            property bool checked: false

            width: 30
            height: 30
            radius: 5

            color: checked ? Colors.uGreen : Colors.uLightGrey

            ULabel.Default
            {
                text: "W"
                color: parent.checked ? Colors.uWhite : Colors.uBlack
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: parent.checked = !parent.checked
            }
        }
        Rectangle
        {
            id: thursdayCheckbox

            property bool checked: false

            width: 30
            height: 30
            radius: 5

            color: checked ? Colors.uGreen : Colors.uLightGrey

            ULabel.Default
            {
                text: "T"
                color: parent.checked ? Colors.uWhite : Colors.uBlack
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: parent.checked = !parent.checked
            }
        }
        Rectangle
        {
            id: fridayCheckbox

            property bool checked: false

            width: 30
            height: 30
            radius: 5

            color: checked ? Colors.uGreen : Colors.uLightGrey

            ULabel.Default
            {
                text: "F"
                color: parent.checked ? Colors.uWhite : Colors.uBlack
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: parent.checked = !parent.checked
            }
        }
        Rectangle
        {
            id: saturdayCheckbox

            property bool checked: false

            width: 30
            height: 30
            radius: 5

            color: checked ? Colors.uGreen : Colors.uLightGrey

            ULabel.Default
            {
                text: "S"
                color: parent.checked ? Colors.uWhite : Colors.uBlack
                anchors.centerIn: parent
            }

            MouseArea
            {
                anchors.fill: parent
                onClicked: parent.checked = !parent.checked
            }
        }
    }

    function getValue()
    {
        return (sundayCheckbox.checked ? 1 : 0) +
                (mondayCheckbox.checked ? 2 : 0) +
                (tuesdayCheckbox.checked ? 4 : 0) +
                (wednesdayCheckbox.checked ? 8 : 0) +
                (thursdayCheckbox.checked ? 16 : 0) +
                (fridayCheckbox.checked ? 32 : 0) +
                (saturdayCheckbox.checked ? 64 : 0)
    }

    function setValue(value)
    {
        sundayCheckbox.checked = value & 1
        mondayCheckbox.checked = value & 2
        tuesdayCheckbox.checked = value & 4
        wednesdayCheckbox.checked = value & 8
        thursdayCheckbox.checked = value & 16
        fridayCheckbox.checked = value & 32
        saturdayCheckbox.checked = value & 64
    }
}
