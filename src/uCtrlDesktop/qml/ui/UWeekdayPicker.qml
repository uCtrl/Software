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
}
