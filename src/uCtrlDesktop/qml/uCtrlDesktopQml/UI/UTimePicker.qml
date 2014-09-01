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
    property string currentValue: "12:00"

    function setCurrentValue(newValue) {
        currentValue = newValue
        analyzeValue()
    }

    Component.onCompleted: {
        analyzeValue()
    }

    function analyzeValue()
    {
        var str = currentValue.split(":")
        hourSelector.changeValue(parseInt(str[0]))
        minuteSelector.changeValue(parseInt(str[1]))
        computeValue()
    }

    function computeValue() {
        currentValue = hourSelector.getFormattedCurrentValue() + ":" + minuteSelector.getFormattedCurrentValue()
        summaryLabel.text = currentValue
    }

    radius: radiusSize

    Rectangle {
        id: iconContainer
        width: parent.height
        height: parent.height

        color: _colors.uTransparent

        UFontAwesome {
            id: icon
            iconId: "Time"
            iconSize: 10
            iconColor: _colors.uGrey

            anchors.centerIn: parent
        }
    }

    Rectangle {
        id: content

        width: summaryLabel.width + 1
        height: parent.height

        anchors.left: iconContainer.right

        clip: true

        color: _colors.uTransparent

        ULabel.Default {
            id: summaryLabel
            anchors.verticalCenter: parent.verticalCenter
            text: "12:00"
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
            iconColor: _colors.uGrey
        }

        Rectangle {
            id: dropDownArea

            anchors.top: dropDownArrow.bottom
            width: dropDownContent.width + 10
            height: dropDownContent.height + 10
            radius: radiusSize

            color: _colors.uGrey

            Rectangle {
                id: dropDownContent
                width: timePickerArea.width + 10
                height: timePickerArea.height + 10
                anchors.centerIn: parent

                color: _colors.uWhite

                Rectangle {
                    id: timePickerArea
                    width: hourSelector.width + colonSeparatorContainer.width + minuteSelector.width
                    height: hourSelector.height
                    anchors.centerIn: parent

                    UNumberSelector {
                        id: hourSelector

                        width: 50
                        height: 100

                        currentValue: 12
                        minValue: 0
                        maxValue: 23

                        onCurrentValueChanged: computeValue()
                    }
                    Rectangle {
                        id: colonSeparatorContainer
                        width: 15
                        height: hourSelector.height

                        anchors.left: hourSelector.right

                        ULabel.Default {
                            text: ":"

                            anchors.centerIn: parent
                        }
                    }
                    UNumberSelector {
                        id: minuteSelector

                        width: hourSelector.width
                        height: hourSelector.height

                        anchors.left: colonSeparatorContainer.right

                        currentValue: 0
                        minValue: 0
                        maxValue: 59
                        offsetPerClick: 5

                        onCurrentValueChanged: computeValue()

                        onOverflow: {
                            hourSelector.addOffset()
                        }
                        onUnderflow: {
                            hourSelector.removeOffset()
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
