import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: datePicker

    width: iconContainer.width + content.width + 10
    height: 30

    color: _colors.uWhite
    border.color: _colors.uGrey
    border.width: 1

    state: "ENABLED"

    property string debugName: "UNKNOWN"

    radius: 5

    property var datePickerModel: []

    property var months: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    property var selectedDate: new Date()

    property int currentMonthDisplayed
    property int currentYearDiplayed

    property bool isComponentCompleted: false

    onSelectedDateChanged: {
        if(isComponentCompleted) {
            summaryLabel.text = selectedDate.toLocaleDateString()
            changeMonth(selectedDate.getMonth(), selectedDate.getFullYear())
            dropDownContainer.visible = false
        }
    }

    Component.onCompleted: {
        summaryLabel.text = selectedDate.toLocaleDateString()
        changeMonth(selectedDate.getMonth(), selectedDate.getFullYear())

        isComponentCompleted = true
    }

    function changeMonth(newMonth, newYear) {
        currentMonthDisplayed = newMonth
        currentYearDiplayed = newYear

        var currentMonth = new Date(newYear, newMonth, 1)
        var lastDayOfCurrentMonth = new Date(newYear, newMonth + 1, 0)
        monthLabel.text = datePicker.months[currentMonth.getMonth()] + " " + currentMonth.getFullYear();

        var previousMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth(), 0)
        var currentDay = currentMonth.getDay()
        var nextMonth = new Date(currentMonth.getFullYear(), currentMonth.getMonth()+1, 1)

        var dateModel = []
        for(var i = -currentDay; i < 0; i++)
        {
            dateModel.push({ "year":previousMonth.getFullYear(), "month":previousMonth.getMonth(), "date":previousMonth.getDate()+i, "isCurrentMonth": false })
        }
        for(var i = 0; i < lastDayOfCurrentMonth.getDate(); i++)
        {
            dateModel.push({ "year":currentMonth.getFullYear(), "month":currentMonth.getMonth(), "date":i, "isCurrentMonth": true })
        }
        for(var i = 0; i < 7 - lastDayOfCurrentMonth.getDay() - 1; i++)
        {
            dateModel.push({ "year":nextMonth.getFullYear(), "month":nextMonth.getMonth(), "date":i, "isCurrentMonth": false })
        }

        datePickerModel = dateModel
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
            anchors.leftMargin: datePicker.height / 2

            iconSize: 24
            iconId: "CaretUp"
            iconColor: _colors.uGrey
        }

        Rectangle {
            id: dropDownArea

            anchors.top: dropDownArrow.bottom
            width: calendarArea.width + 10
            height: calendarArea.height + 45
            radius: 5

            color: _colors.uGrey

            Rectangle {
                id: monthArea

                width: calendarArea.width
                height: 30

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 5
                anchors.topMargin: 5

                color: _colors.uTransparent

                UButton {
                    id: previousMonthButton

                    anchors.left: parent.left

                    iconId: "CaretLeft"

                    width: parent.height
                    height: parent.height

                    buttonColor: _colors.uTransparent
                    buttonHoveredColor: _colors.uDarkGrey

                    onClicked: changeMonth(currentMonthDisplayed - 1, currentYearDiplayed)
                }

                Rectangle {
                    id: monthLabelContainer

                    anchors.left: previousMonthButton.right
                    anchors.right: nextMonthButton.left
                    height: parent.height

                    color: _colors.uTransparent

                    ULabel.Default {
                        id: monthLabel
                        anchors.centerIn: parent

                        text: "UNKNOWN"
                        color: _colors.uWhite
                        font.bold: true
                        font.pointSize: 14
                    }
                }

                UButton {
                    id: nextMonthButton

                    anchors.right: parent.right

                    iconId: "CaretRight"

                    width: parent.height
                    height: parent.height

                    buttonColor: _colors.uTransparent
                    buttonHoveredColor: _colors.uDarkGrey

                    onClicked: changeMonth(currentMonthDisplayed + 1, currentYearDiplayed)
                }

            }

            Rectangle {
                id: calendarArea
                width: weekRow.width
                height: weekRow.height * ((datePickerModel.length / 7 + 1) | 0)
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 5
                anchors.left: parent.left
                anchors.leftMargin: 5

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
                    id: calendarRow

                    anchors.top: weekRow.bottom
                    anchors.bottom: parent.bottom
                    width: parent.width

                    color: _colors.uTransparent

                    GridView {
                        id: calendarGrid

                        anchors.fill: parent
                        cellWidth: 30
                        cellHeight: 30
                        delegate: calendarCell

                        interactive: false

                        model: datePickerModel
                    }

                    Component {
                        id: calendarCell

                        Rectangle {
                            id: cellContainer

                            width: 30
                            height: 30

                            property bool isSelected: ((selectedDate.getFullYear() === datePickerModel[index].year) &&
                                                       (selectedDate.getMonth() === datePickerModel[index].month) &&
                                                       (selectedDate.getDate() - 1 === datePickerModel[index].date))

                            color: isSelected ? _colors.uGreen : _colors.uTransparent
                            radius: 5

                            UButton {
                                anchors.fill: parent
                                text: datePickerModel[index].date + 1
                                buttonColor: _colors.uTransparent
                                buttonTextColor: {
                                    if(cellContainer.isSelected)
                                        return _colors.uWhite
                                    else
                                        return (datePickerModel[index].isCurrentMonth ? _colors.uBlack : _colors.uGrey)
                                }
                                buttonHoveredColor: cellContainer.isSelected ? _colors.uDarkGreen : _colors.uDarkGrey
                                buttonHoveredTextColor: _colors.uWhite
                                bold: false

                                onClicked: {
                                    selectedDate = new Date(datePickerModel[index].year, datePickerModel[index].month, datePickerModel[index].date+1)
                                }

                            }
                        }
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent

        cursorShape: (datePicker.state !== "DISABLED" ? (containsMouse ? Qt.PointingHandCursor : Qt.ArrowCursor) : Qt.ArrowCursor);
        hoverEnabled: true
        onClicked: {
            dropDownContainer.visible = !dropDownContainer.visible
            changeMonth(selectedDate.getMonth(), selectedDate.getFullYear())
        }
    }
}
