import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../label" as ULabel
import "UColors.js" as Colors

Rectangle {
    id: datePicker

    width: iconContainer.width + content.width + 10
    height: 30

    property int radiusSize: 5
    property int cellSize: 30
    property int cellHeight: 25

    color: Colors.uWhite
    border.color: Colors.uGrey
    border.width: 1

    state: "ENABLED"

    property string debugName: "UNKNOWN"

    radius: radiusSize

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

        color: Colors.uTransparent

        UFontAwesome {
            id: icon
            iconId: "Calendar"
            iconSize: 10
            iconColor: Colors.uGrey

            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: content

        width: summaryLabel.width
        height: parent.height

        anchors.left: iconContainer.right

        clip: true

        color: Colors.uTransparent

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
            iconColor: Colors.uGrey
        }

        Rectangle {
            id: dropDownArea

            anchors.top: dropDownArrow.bottom
            width: calendarArea.width + 10
            height: calendarArea.height + 45
            radius: radiusSize

            color: Colors.uGrey

            Rectangle {
                id: monthArea

                width: calendarArea.width
                height: 30

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 5
                anchors.topMargin: 5

                color: Colors.uTransparent

                UButton {
                    id: previousMonthButton

                    anchors.left: parent.left

                    iconId: "CaretLeft"

                    width: parent.height
                    height: parent.height

                    buttonColor: Colors.uTransparent
                    buttonHoveredColor: Colors.uDarkGrey

                    onClicked: changeMonth(currentMonthDisplayed - 1, currentYearDiplayed)
                }

                Rectangle {
                    id: monthLabelContainer

                    anchors.left: previousMonthButton.right
                    anchors.right: nextMonthButton.left
                    height: parent.height

                    color: Colors.uTransparent

                    ULabel.Default {
                        id: monthLabel
                        anchors.centerIn: parent

                        text: "UNKNOWN"
                        color: Colors.uWhite
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

                    buttonColor: Colors.uTransparent
                    buttonHoveredColor: Colors.uDarkGrey

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

                color: Colors.uWhite


                Rectangle {
                    id: weekRow
                    width: datePicker.cellSize * 7
                    height: datePicker.cellHeight

                    color: Colors.uTransparent

                    Rectangle {
                        id: sundayLabel

                        width: datePicker.cellSize
                        height: datePicker.cellHeight

                        color: Colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "S"
                        }
                    }
                    Rectangle {
                        id: mondayLabel

                        width: datePicker.cellSize
                        height: datePicker.cellHeight

                        anchors.left: sundayLabel.right

                        color: Colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "M"
                        }
                    }
                    Rectangle {
                        id: tuesdayLabel

                        width: datePicker.cellSize
                        height: datePicker.cellHeight

                        anchors.left: mondayLabel.right

                        color: Colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "T"
                        }
                    }
                    Rectangle {
                        id: wednesdayLabel

                        width: datePicker.cellSize
                        height: datePicker.cellHeight

                        anchors.left: tuesdayLabel.right

                        color: Colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "W"
                        }
                    }
                    Rectangle {
                        id: thursdayLabel

                        width: datePicker.cellSize
                        height: datePicker.cellHeight

                        anchors.left: wednesdayLabel.right

                        color: Colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "T"
                        }
                    }
                    Rectangle {
                        id: fridayLabel

                        width: datePicker.cellSize
                        height: datePicker.cellHeight

                        anchors.left: thursdayLabel.right

                        color: Colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "F"
                        }
                    }
                    Rectangle {
                        id: saturdayLabel

                        width: datePicker.cellSize
                        height: datePicker.cellHeight

                        anchors.left: fridayLabel.right

                        color: Colors.uTransparent

                        ULabel.UWeekDayPickerLabel {
                            text: "S"
                        }
                    }
                }

                Rectangle {
                    id: calendarRow

                    anchors.top: weekRow.bottom
                    anchors.bottom: parent.bottom
                    width: parent.width

                    color: Colors.uTransparent

                    GridView {
                        id: calendarGrid

                        anchors.fill: parent
                        cellWidth: datePicker.cellSize
                        cellHeight: datePicker.cellHeight
                        delegate: calendarCell

                        interactive: false

                        model: datePickerModel
                    }

                    Component {
                        id: calendarCell

                        Rectangle {
                            id: cellContainer

                            width: datePicker.cellSize
                            height: datePicker.cellHeight

                            property bool isSelected: ((selectedDate.getFullYear() === datePickerModel[index].year) &&
                                                       (selectedDate.getMonth() === datePickerModel[index].month) &&
                                                       (selectedDate.getDate() - 1 === datePickerModel[index].date))

                            color: isSelected ? Colors.uGreen : Colors.uTransparent
                            radius: radiusSize

                            UButton {
                                anchors.fill: parent
                                text: datePickerModel[index].date + 1
                                buttonColor: Colors.uTransparent
                                buttonTextColor: {
                                    if(cellContainer.isSelected)
                                        return Colors.uWhite
                                    else
                                        return (datePickerModel[index].isCurrentMonth ? Colors.uBlack : Colors.uGrey)
                                }
                                buttonHoveredColor: cellContainer.isSelected ? Colors.uDarkGreen : Colors.uDarkGrey
                                buttonHoveredTextColor: Colors.uWhite
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
