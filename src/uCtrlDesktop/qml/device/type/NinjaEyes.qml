import QtQuick 2.0

import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

import jbQuick.Charts 1.0
import "../../jbQuick/Charts/QChartGallery.js" as ChartsData

Rectangle {
    id: container

    width: parent.width

    property var model: null
    property string unitLabel : ""

    Rectangle {
        id: valueContainer

        color: Colors.uTransparent

        width: parent.width
        height: editValueMode ? 190 : 105

        anchors.top: container.top
        anchors.topMargin: 5

        anchors.left: container.left

        property bool editValueMode: false

        ULabel.Default {
            id: currentValueLabel

            text: "CURRENT VALUE"

            font.bold: true
            font.pixelSize: 9

            anchors.top: valueContainer.top
            anchors.topMargin: 5

            anchors.left: valueContainer.left

            color: Colors.uGrey
        }

        Rectangle
        {
            width: 50
            height: 50
            color: Colors.uTransparent
            anchors.verticalCenter: parent.verticalCenter

            Image
            {
                id: ninjaIcon
                source: "qrc:/Images/NinjaIcon.png"
                sourceSize: Qt.size(parent.width, parent.height)
                smooth: true

                visible: !valueContainer.editValueMode
            }

            Image
            {
                id: ninjaIconEyes
                source: "qrc:/Images/NinjaIconEyes.png"
                sourceSize: Qt.size(parent.width, parent.height)
                smooth: true
                visible: false
            }

            ColorOverlay {
                anchors.fill: parent
                source: ninjaIconEyes
                color: getValue()

                visible: !valueContainer.editValueMode
            }
        }

        UI.UButton
        {
            id: editButton

            iconId: "pencil"

            iconSize: 12

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            width: 40

            buttonTextColor: Colors.uGrey
            buttonColor: Colors.uTransparent
            buttonHoveredTextColor: Colors.uGreen
            buttonHoveredColor: Colors.uTransparent

            onClicked: {
                valueContainer.editValueMode = !valueContainer.editValueMode
                colorPicker.hsbFromRgb(getValue())
            }

            visible : !valueContainer.editValueMode
        }

        UI.UColorPicker
        {
            id: colorPicker
            anchors.bottom: parent.bottom
            visible : valueContainer.editValueMode
        }

        UI.USaveCancel
        {
            anchors.right: parent.right
            anchors.verticalCenter: colorPicker.verticalCenter

            visible : valueContainer.editValueMode

            onSave: {
                //Send manual command
                model.value = colorPicker.pickerString
                uCtrlApiFacade.putDevice(devicesList.findObject(model.id))

                valueContainer.editValueMode = false
            }

            onCancel: {
                valueContainer.editValueMode = false
            }
        }
    }

    Rectangle {
        id: statsContainer

        anchors.left: container.left
        anchors.right: container.right

        anchors.top: valueContainer.bottom
        anchors.bottom: container.bottom

        color: Colors.uTransparent

        Rectangle {
            id: chartContainer
            anchors.top: statsHeader.bottom
            anchors.bottom: carouselContainer.top

            clip: true
            width: parent.width

            UI.UChart {
                id: stateChart
                chartAnimated: false
                chartName: "Number of changes"
                chartData: {
                               "labels": ["06:10am","07:10am","08:10am","09:10am","10:10am","11:10am","12:10am"],
                               "axisY": [0, 25, 50, 75, 100],
                               "datasets": [{
                                   fillColor: Colors.uGreen,
                                   strokeColor: Colors.uDarkGreen,
                                   pointColor: Colors.uGreen,
                                   pointStrokeColor: Colors.uGreen,
                                   data: [0, 55, 15, 75, 100, 0, 50],
                               }]
                           }
                width: chartContainer.width
                height: chartContainer.height

                chartType: Charts.ChartType.BAR

                z: 2
            }

            UI.UChart {
                id: powerChart
                chartAnimated: false
                chartName: "Power consumption"
                chartData: {
                               "labels": ["06:10am","07:10am","08:10am","09:10am","10:10am","11:10am","12:10am"],
                               "axisY": [0, 25, 50, 75, 100],
                               "datasets": [{
                                   fillColor: "rgba(237,237,237,0.5)",
                                   strokeColor: Colors.uMediumLightGrey,
                                   pointColor: Colors.uGreen,
                                   pointStrokeColor: Colors.uGreen,
                                   data: [0, 15, 20, 23, 25, 60, 67]
                               }]
                           }
                width: chartContainer.width
                height: chartContainer.height
                chartType: Charts.ChartType.LINE
            }
        }

        Rectangle {
            id: carouselContainer
            width: parent.width
            height: 30
            anchors.bottom: parent.bottom

            UI.UCarousel {
                carouselItems:  [stateChart, powerChart]
                carouselIcons: ["info", "lightning"]
                onChangeItem: {
                    statsText.text = "Statistics : " + item.chartName
                }
            }
        }

        Rectangle {
            id: statsHeader
            width: parent.width
            height: 40

            anchors.top: statsContainer.top

            UI.UFontAwesome {
                id: statsIcon
                iconId: "stats"
                iconSize: 12
                iconColor: Colors.uGrey
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }

            ULabel.Default {
                id: statsText
                text: "Statistics"
                anchors.left: statsIcon.right
                anchors.leftMargin: 15
                color: Colors.uGrey
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
            }

            UI.UCombobox {
                id: periodCombo

                property var periods: [
                    { value: "today",     displayedValue: "Today", iconId: ""},
                    { value: "week",   displayedValue: "This week", iconId: ""},
                    { value: "month",   displayedValue: "This month", iconId: ""},
               ]

                itemListModel: periods

                anchors.right: parent.right

                itemColor: Colors.uTransparent
                itemTextColor: Colors.uGreen

                dropdownColor: Colors.uGreen
                dropdownTextColor: Colors.uWhite

                selectedItemColor: Colors.uDarkGreen
                selectedItemTextColor: Colors.uWhite
                selectedItemHoverColor: Colors.uWhite
                selectedItemHoverTextColor: Colors.uGreen

                hoverColor: Colors.uDarkGreen
                hoverTextColor: Colors.uWhite

                height: parent.height;
                width: 150

                Component.onCompleted: selectItem(0)

                z: 3
            }
        }
    }

    function getDeviceEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
    }

    function getValue() {
        if (model !== null) return "#" + model.value
        else return "#FFFFFF"
    }

    function getPrecision() {
        if (model !== null) return model.precision
        else return "0.1"
    }
}
