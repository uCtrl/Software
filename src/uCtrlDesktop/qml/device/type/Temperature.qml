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

        anchors.top: container.top
        anchors.left: container.left

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

                anchors.left: periodContainer.left
                anchors.leftMargin: 5

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

    Rectangle {
        id: firmware

        anchors.top: currentValue.bottom
        anchors.bottom: container.bottom

        anchors.left: parent.left

        width: (container.width / 2)

        color: Colors.uTransparent

        Rectangle {
            id: firmwareContainer

            anchors.top: firmware.top
            anchors.topMargin: 10

            anchors.left: firmware.left
            anchors.right: firmware.right

            height: 15

            color: Colors.uTransparent

            UI.UFontAwesome {
                id: firmwareIcon

                anchors.left: firmwareContainer.left
                anchors.leftMargin: 20

                anchors.verticalCenter: firmwareContainer.verticalCenter

                iconColor: Colors.uGreen
                iconSize: 14
                iconId: "Cog"
            }

            ULabel.Default {
                id: firmwareText

                anchors.left: firmwareIcon.right
                anchors.leftMargin: 15

                anchors.verticalCenter: firmwareContainer.verticalCenter

                text: "TECHNICAL INFORMATION"

                font.bold: true
                font.pointSize: 10

                color: Colors.uGreen
            }
        }

        Rectangle {
            id: typeContainer

            anchors.left: firmware.left
            anchors.leftMargin: 15

            anchors.right: firmware.right
            anchors.rightMargin: 15

            anchors.top: firmwareContainer.bottom
            anchors.topMargin: 5

            height: 15

            ULabel.Default {
                id: typeLabel

                anchors.left: typeContainer.left
                anchors.verticalCenter: typeContainer.verticalCenter

                font.bold: true
                font.pointSize: 11

                color: Colors.uMediumDarkGrey

                text: "TYPE"
            }

            ULabel.Default {
                id: typeValue

                anchors.right: typeContainer.right
                anchors.verticalCenter: typeContainer.verticalCenter

                font.bold: false
                font.pointSize: 11

                color: Colors.uGrey

                text: getModel()
            }
        }

        Rectangle {
            id: modelContainer

            anchors.left: firmware.left
            anchors.leftMargin: 15

            anchors.right: firmware.right
            anchors.rightMargin: 15

            anchors.top: typeContainer.bottom

            height: 15

            ULabel.Default {
                id: modelLabel

                anchors.left: modelContainer.left
                anchors.verticalCenter: modelContainer.verticalCenter

                font.bold: true
                font.pointSize: 11

                color: Colors.uMediumDarkGrey

                text: "MODEL"
            }

            ULabel.Default {
                id: modelValue

                anchors.right: modelContainer.right
                anchors.verticalCenter: modelContainer.verticalCenter

                font.bold: false
                font.pointSize: 11

                color: Colors.uGrey

                text: getType()
            }
        }

        Rectangle {
            id: guidContainer

            anchors.left: firmware.left
            anchors.leftMargin: 15

            anchors.right: firmware.right
            anchors.rightMargin: 15

            anchors.top: modelContainer.bottom

            height: 15

            ULabel.Default {
                id: guidLabel

                anchors.left: guidContainer.left
                anchors.verticalCenter: guidContainer.verticalCenter

                font.bold: true
                font.pointSize: 11

                color: Colors.uMediumDarkGrey

                text: "GUID"
            }

            ULabel.Default {
                id: guidValue

                anchors.right: guidContainer.right
                anchors.verticalCenter: guidContainer.verticalCenter

                font.bold: false
                font.pointSize: 11

                color: Colors.uGrey

                text: getGUID()
            }
        }

        Rectangle {
            id: firmMinContainer

            anchors.left: firmware.left
            anchors.leftMargin: 15

            anchors.right: firmware.right
            anchors.rightMargin: 15

            anchors.top: guidContainer.bottom

            height: 15

            ULabel.Default {
                id: firmMinLabel

                anchors.left: firmMinContainer.left
                anchors.verticalCenter: firmMinContainer.verticalCenter

                font.bold: true
                font.pointSize: 11

                color: Colors.uMediumDarkGrey

                text: "MINIMUM VALUE"
            }

            ULabel.Default {
                id: firmMinValue

                anchors.right: firmMinContainer.right
                anchors.verticalCenter: firmMinContainer.verticalCenter

                font.bold: false
                font.pointSize: 11

                color: Colors.uGrey

                text: getMinValue()
            }
        }

        Rectangle {
            id: firmMaxContainer

            anchors.left: firmware.left
            anchors.leftMargin: 15

            anchors.right: firmware.right
            anchors.rightMargin: 15

            anchors.top: firmMinContainer.bottom

            height: 15

            ULabel.Default {
                id: firmMaxLabel

                anchors.left: firmMaxContainer.left
                anchors.verticalCenter: firmMaxContainer.verticalCenter

                font.bold: true
                font.pointSize: 11

                color: Colors.uMediumDarkGrey

                text: "MAXIMUM VALUE"
            }

            ULabel.Default {
                id: firmMaxValue

                anchors.right: firmMaxContainer.right
                anchors.verticalCenter: firmMaxContainer.verticalCenter

                font.bold: false
                font.pointSize: 11

                color: Colors.uGrey

                text: getMaxValue()
            }
        }
    }

    Rectangle {
        id: graph

        anchors.top: currentValue.bottom
        anchors.bottom: container.bottom

        anchors.left: firmware.right

        width: (container.width / 2)

        color: Colors.uTransparent
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

    function getModel() {
        return "La Crosse Temp WS2355"
    }

    function getType() {
        return "Thermometer (sensor)"
    }

    function getGUID() {
        return "12312412412321"
    }

    function getMinValue() {
        if (item !== null) return item.minValue
        else return "-70"
    }

    function getMaxValue() {
        if (item !== null) return item.maxValue
        else return "70"
    }
}
