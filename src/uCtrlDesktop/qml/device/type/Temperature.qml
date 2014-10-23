import QtQuick 2.0

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    property var item: main.activeDevice

    property variant periods: [
        { value: "today",     displayedValue: "Today", iconId: ""},
        { value: "week",   displayedValue: "This week", iconId: ""},
        { value: "month",   displayedValue: "This month", iconId: ""},
   ]

    color: Colors.uTransparent

    Rectangle {
        id: currentValue

        anchors.top: parent.top
        anchors.left: parent.left

        height: 125; width: 250

        color: Colors.uTransparent

        Rectangle {
            id: labelContainer

            anchors.top: currentValue.top
            anchors.topMargin: 10

            anchors.left: currentValue.left
            anchors.right: currentValue.right

            height: 20

            color: Colors.uTransparent

            UI.UFontAwesome {
                id: labelIcon

                anchors.left: labelContainer.left
                anchors.leftMargin: 20

                anchors.verticalCenter: labelContainer.verticalCenter

                iconColor: Colors.uGreen
                iconSize: 14
                iconId: "info"
            }

            ULabel.Default {
                id: labelText

                anchors.left: labelIcon.right
                anchors.leftMargin: 15

                anchors.verticalCenter: labelContainer.verticalCenter

                text: "CURRENT VALUE"

                font.bold: true
                font.pointSize: 10

                color: Colors.uGreen
            }
        }

        Rectangle {
            id: valueContainer

            anchors.left: currentValue.left

            anchors.top: labelContainer.top
            anchors.bottom: currentValue.bottom

            width: (currentValue.width - unitContainer.width)

            color: Colors.uTransparent

            ULabel.Default {
                id: valueText

                anchors.right: valueContainer.right
                anchors.rightMargin: 5

                anchors.verticalCenter: valueContainer.verticalCenter

                text: getValue()

                font.bold: true
                font.pointSize: 78

                color: Colors.uMediumDarkGrey
            }
        }

        Rectangle {
            id: unitContainer

            anchors.right: currentValue.right
            anchors.top: currentValue.top

            height: (currentValue.height / 2); width: 60

            color: Colors.uTransparent

            ULabel.Default {
                id: unitText

                anchors.horizontalCenter: unitContainer.horizontalCenter
                anchors.bottom: unitContainer.bottom

                text: getUnit()

                font.bold: true
                font.pointSize: 32

                color: Colors.uGrey
            }
        }

        Rectangle {
            id: precisionContainer

            anchors.right: currentValue.right
            anchors.top: unitContainer.bottom

            height: unitContainer.height; width: unitContainer.width

            color: Colors.uTransparent

            ULabel.Default {
                id: precisionText

                anchors.horizontalCenter: precisionContainer.horizontalCenter

                anchors.top: precisionContainer.top
                anchors.topMargin: 10

                text: "±0." + getPrecision()

                font.bold: false
                font.pointSize: 20

                color: Colors.uGrey
            }
        }
    }

    Rectangle {
        id: overview

        property int marginSize: 20

        anchors.top: parent.top
        anchors.topMargin: marginSize

        anchors.left: currentValue.right

        height: currentValue.height - (marginSize * 2); width: parent.width - currentValue.width

        color: Colors.uTransparent

        z: 1

        Rectangle {
            id: periodContainer

            anchors.left: overview.left
            anchors.right: overview.right

            anchors.top: overview.top
            anchors.topMargin: 10

            height: 25

            color: Colors.uTransparent

            UI.UCombobox {
                id: periodCombo

                itemListModel: periods

                anchors.right: periodContainer.right
                anchors.rightMargin: 10

                anchors.top: periodContainer.top

                itemColor: Colors.uTransparent
                itemTextColor: Colors.uGreen

                dropdownColor: Colors.uGreen
                dropdownTextColor: Colors.uWhite

                selectedItemColor: Colors.uGreen
                selectedItemTextColor: Colors.uWhite
                selectedItemHoverColor: Colors.uWhite
                selectedItemHoverTextColor: Colors.uGreen

                hoverColor: Colors.uDarkGreen
                hoverTextColor: Colors.uWhite

                height: periodContainer.height; width: 100

                Component.onCompleted: selectItem(0)

                z: 3
            }

            z: 2
        }

        Rectangle {
            id: averageContainer

            anchors.left: overview.left
            anchors.top: periodContainer.bottom
            anchors.bottom: overview.bottom

            width: 90

            ULabel.Default {
                id: averageLabel

                anchors.top: averageContainer.top

                anchors.horizontalCenter: averageContainer.horizontalCenter

                text: "AVERAGE"

                font.bold: true
                font.pointSize: 12

                color: Colors.uGrey
            }

            ULabel.Default {
                id: averageValue

                anchors.top: averageLabel.bottom

                anchors.horizontalCenter: averageContainer.horizontalCenter

                text: getValue()

                font.bold: true
                font.pointSize: 28

                color: Colors.uDarkGreen
            }
        }

        Rectangle {
            id: minContainer

            anchors.left: averageContainer.right
            anchors.top: periodContainer.bottom
            anchors.bottom: overview.bottom

            width: 90

            ULabel.Default {
                id: minLabel

                anchors.top: minContainer.top

                anchors.horizontalCenter: minContainer.horizontalCenter

                text: "MIN. VALUE"

                font.bold: true
                font.pointSize: 12

                color: Colors.uGrey
            }

            ULabel.Default {
                id: minValue

                anchors.top: minLabel.bottom

                anchors.horizontalCenter: minContainer.horizontalCenter

                text: getValue()

                font.bold: true
                font.pointSize: 28

                color: Colors.uDarkGreen
            }
        }

        Rectangle {
            id: maxContainer

            anchors.left: minContainer.right
            anchors.top: periodContainer.bottom
            anchors.bottom: overview.bottom

            width: 90

            ULabel.Default {
                id: maxLabel

                anchors.top: maxContainer.top

                anchors.horizontalCenter: maxContainer.horizontalCenter

                text: "MAX. VALUE"

                font.bold: true
                font.pointSize: 12

                color: Colors.uGrey
            }

            ULabel.Default {
                id: maxValue

                anchors.top: maxLabel.bottom

                anchors.horizontalCenter: maxContainer.horizontalCenter

                text: getValue()

                font.bold: true
                font.pointSize: 28

                color: Colors.uDarkGreen
            }
        }
    }

    function getValue() {
        if (item !== null) return item.value
        else return 0
    }

    function getUnit() {
        if (item !== null) return item.unitLabel
        else return "C"

    }

    function getPrecision() {
        if (item !== null) return item.precision
        else return "0.1"
    }
}
