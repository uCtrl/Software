import QtQuick 2.0
import ConditionEnums 1.0

import "ULabel" as ULabel


Rectangle {
    id: weekdayPicker

    width: iconContainer.width + content.width + 10
    height: 30

    color: _colors.uWhite
    border.color: _colors.uGrey
    border.width: 1

    state: "ENABLED"
    property int value: 0

    radius: 5

    onValueChanged: checkSelected()

    function checkSelected() {
        sundayCheckbox.checked = (value & UEWeekday.Sunday) == UEWeekday.Sunday
        saturdayCheckbox.checked = (value & UEWeekday.Saturday) == UEWeekday.Saturday
        fridayCheckbox.checked = (value & UEWeekday.Friday) == UEWeekday.Friday
        thursdayCheckbox.checked = (value & UEWeekday.Thursday) == UEWeekday.Thursday
        wednesdayCheckbox.checked = (value & UEWeekday.Wednesday) == UEWeekday.Wednesday
        tuesdayCheckbox.checked = (value & UEWeekday.Tuesday) == UEWeekday.Tuesday
        mondayCheckbox.checked = (value & UEWeekday.Monday) == UEWeekday.Monday

        updateDisplay()
    }

    function updateDisplay() {
        summaryLabel.text = (sundayCheckbox.checked ? "Sunday " : "") +
                            (mondayCheckbox.checked ? "Monday " : "") +
                            (tuesdayCheckbox.checked ? "Tuesday " : "") +
                            (wednesdayCheckbox.checked ? "Wednesday " : "") +
                            (thursdayCheckbox.checked ? "Thursday " : "") +
                            (fridayCheckbox.checked ? "Friday " : "") +
                            (saturdayCheckbox.checked ? "Saturday" : "")
        if(summaryLabel.text === "") {
            summaryLabel.text = "-"
        }
    }

    function computeValue() {
        weekDayPicker.value = (mondayCheckbox.checked ? UEWeekday.Monday : 0) +
                              (tuesdayCheckbox.checked ? UEWeekday.Tuesday : 0) +
                              (wednesdayCheckbox.checked ? UEWeekday.Wednesday : 0) +
                              (thursdayCheckbox.checked ? UEWeekday.Thursday : 0) +
                              (fridayCheckbox.checked ? UEWeekday.Friday : 0) +
                              (saturdayCheckbox.checked ? UEWeekday.Saturday : 0) +
                              (sundayCheckbox.checked ? UEWeekday.Sunday : 0)
    }

    Rectangle {
        id: iconContainer
        width: parent.height
        height: parent.height

        color: _colors.uTransparent

        UFontAwesome {
            id: icon
            iconId: "Calendar"
            iconSize: 10
            iconColor: _colors.uGrey

            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: content

        width: summaryLabel.width
        height: parent.height

        anchors.left: iconContainer.right

        clip: true

        color: _colors.uTransparent

        ULabel.Default {
            id: summaryLabel
            anchors.verticalCenter: parent.verticalCenter
            text: "-"
        }
    }

    Rectangle {
        id: dropDownContainer
        anchors.top: parent.bottom
        anchors.topMargin: 10
        anchors.left: parent.left

        visible: false

        UFontAwesome {
            id: dropDownArrow
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: weekdayPicker.height / 2

            iconSize: 24
            iconId: "CaretUp"
            iconColor: _colors.uGreen
        }

        Rectangle {
            id: dropDownArea

            anchors.top: dropDownArrow.bottom
            width: dropDownContent.width + 10
            height: dropDownContent.height + 10
            radius: 5

            color: _colors.uGreen

            Rectangle {
                id: dropDownContent
                width: weekRow.width
                height: weekRow.height + checkboxRow.height
                anchors.centerIn: parent

                color: _colors.uWhite

                Rectangle {
                    id: weekRow
                    width: 30 * 7
                    height: 30

                    color: _colors.uTransparent

                    Rectangle {
                        id: sundayLabel

                        width: parent.height
                        height: parent.height

                        color: _colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "Su"
                        }
                    }
                    Rectangle {
                        id: mondayLabel

                        width: parent.height
                        height: parent.height

                        anchors.left: sundayLabel.right

                        color: _colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "Mo"
                        }
                    }
                    Rectangle {
                        id: tuesdayLabel

                        width: parent.height
                        height: parent.height

                        anchors.left: mondayLabel.right

                        color: _colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "Tu"
                        }
                    }
                    Rectangle {
                        id: wednesdayLabel

                        width: parent.height
                        height: parent.height

                        anchors.left: tuesdayLabel.right

                        color: _colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "We"
                        }
                    }
                    Rectangle {
                        id: thursdayLabel

                        width: parent.height
                        height: parent.height

                        anchors.left: wednesdayLabel.right

                        color: _colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "Th"
                        }
                    }
                    Rectangle {
                        id: fridayLabel

                        width: parent.height
                        height: parent.height

                        anchors.left: thursdayLabel.right

                        color: _colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "Fr"
                        }
                    }
                    Rectangle {
                        id: saturdayLabel

                        width: parent.height
                        height: parent.height

                        anchors.left: fridayLabel.right

                        color: _colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "Sa"
                        }
                    }
                }

                Rectangle {
                    id: checkboxRow
                    width: weekRow.width
                    height: weekRow.height

                    anchors.top: weekRow.bottom

                    color: _colors.uTransparent

                    Rectangle {
                        id: sundayCheckboxContainer
                        width: parent.height
                        height: parent.height
                        color: _colors.uTransparent

                        UCheckbox {
                            id: sundayCheckbox
                            anchors.centerIn: parent

                            checkedIconColor: _colors.uWhite
                            checkedContainerBorderColor: _colors.uGreen
                            checkedContainerColor: _colors.uGreen

                            onCheckedChanged: weekDayPicker.computeValue()
                        }
                    }
                    Rectangle {
                        id: mondayCheckboxContainer
                        width: parent.height
                        height: parent.height

                        anchors.left: sundayCheckboxContainer.right

                        color: _colors.uTransparent

                        UCheckbox {
                            id: mondayCheckbox
                            anchors.centerIn: parent

                            checkedIconColor: _colors.uWhite
                            checkedContainerBorderColor: _colors.uGreen
                            checkedContainerColor: _colors.uGreen

                            onCheckedChanged: weekDayPicker.computeValue()
                        }
                    }
                    Rectangle {
                        id: tuesdayCheckboxContainer
                        width: parent.height
                        height: parent.height

                        anchors.left: mondayCheckboxContainer.right

                        color: _colors.uTransparent

                        UCheckbox {
                            id: tuesdayCheckbox
                            anchors.centerIn: parent

                            checkedIconColor: _colors.uWhite
                            checkedContainerBorderColor: _colors.uGreen
                            checkedContainerColor: _colors.uGreen

                            onCheckedChanged: weekDayPicker.computeValue()
                        }
                    }
                    Rectangle {
                        id: wednesdayCheckboxContainer
                        width: parent.height
                        height: parent.height

                        anchors.left: tuesdayCheckboxContainer.right

                        color: _colors.uTransparent

                        UCheckbox {
                            id: wednesdayCheckbox
                            anchors.centerIn: parent

                            checkedIconColor: _colors.uWhite
                            checkedContainerBorderColor: _colors.uGreen
                            checkedContainerColor: _colors.uGreen

                            onCheckedChanged: weekDayPicker.computeValue()
                        }
                    }
                    Rectangle {
                        id: thursdayCheckboxContainer
                        width: parent.height
                        height: parent.height

                        anchors.left: wednesdayCheckboxContainer.right

                        color: _colors.uTransparent

                        UCheckbox {
                            id: thursdayCheckbox
                            anchors.centerIn: parent

                            checkedIconColor: _colors.uWhite
                            checkedContainerBorderColor: _colors.uGreen
                            checkedContainerColor: _colors.uGreen

                            onCheckedChanged: weekDayPicker.computeValue()
                        }
                    }
                    Rectangle {
                        id: fridayCheckboxContainer
                        width: parent.height
                        height: parent.height

                        anchors.left: thursdayCheckboxContainer.right

                        color: _colors.uTransparent

                        UCheckbox {
                            id: fridayCheckbox
                            anchors.centerIn: parent

                            checkedIconColor: _colors.uWhite
                            checkedContainerBorderColor: _colors.uGreen
                            checkedContainerColor: _colors.uGreen

                            onCheckedChanged: weekDayPicker.computeValue()
                        }
                    }
                    Rectangle {
                        id: saturdayCheckboxContainer
                        width: parent.height
                        height: parent.height

                        anchors.left: fridayCheckboxContainer.right

                        color: _colors.uTransparent

                        UCheckbox {
                            id: saturdayCheckbox
                            anchors.centerIn: parent

                            checkedIconColor: _colors.uWhite
                            checkedContainerBorderColor: _colors.uGreen
                            checkedContainerColor: _colors.uGreen

                            onCheckedChanged: weekDayPicker.computeValue()
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        cursorShape: (weekdayPicker.state !== "DISABLED" ? (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor) : Qt.ArrowCursor);
        hoverEnabled: true
        onClicked: {
            dropDownContainer.visible = !dropDownContainer.visible
        }
    }
}
