import QtQuick 2.0

import QtQuick.Controls 1.2

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors

import jbQuick.Charts 1.0
import "../../jbQuick/Charts/QChartGallery.js" as ChartsData

Rectangle {
    id: container

    property var model: null
    property string unitLabel : "°C"

    Rectangle {
        id: valueContainer

        color: Colors.uTransparent

        height: 100; width: 185

        anchors.top: container.top
        anchors.topMargin: 5

        anchors.left: container.left

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

        Rectangle {
            id: currentValueContainer

            color: Colors.uTransparent

            anchors.left: valueContainer.left
            anchors.right: unitContainer.left
            anchors.top: valueContainer.top
            anchors.bottom: valueContainer.bottom

            ULabel.Default {
                id: currentValue

                text: getValue()

                font.bold: true
                font.pixelSize: 68

                color: Colors.uMediumDarkGrey

                anchors.right: currentValueContainer.right
                anchors.verticalCenter: currentValueContainer.verticalCenter
            }
        }

        Rectangle {
            id: unitContainer

            color: Colors.uTransparent

            anchors.right: valueContainer.right
            width: 30

            anchors.top: valueContainer.top
            height: (valueContainer.height / 2)

            ULabel.Default {
                id: unitLabel

                font.pixelSize: 20

                text: container.unitLabel

                color: Colors.uGrey

                anchors.bottom: unitContainer.bottom
                anchors.left: unitContainer.left
            }
        }

        Rectangle {
            id: precisionContainer

            color: Colors.uTransparent

            anchors.left: unitContainer.left
            anchors.right: unitContainer.right
            anchors.top: unitContainer.bottom
            height: unitContainer.height

            ULabel.Default {
                id: precisionLabel

                font.pixelSize: 12

                text: "±0." + getPrecision()

                color: Colors.uGrey

                anchors.top: precisionContainer.precisionContainer
                anchors.left: precisionContainer.left
            }
        }
    }

    Rectangle {
        id: averageContainer

        color: Colors.uTransparent

        height: valueContainer.height; width: 300

        anchors.top: valueContainer.top
        anchors.bottom: valueContainer.bottom

        anchors.left: valueContainer.right

        Rectangle {
            id: averageValueContainer

            anchors.left: averageContainer.left
            anchors.bottom: averageContainer.bottom
            anchors.top: averageContainer.top

            width: (averageContainer.width / 3)

            color: Colors.uTransparent

            ULabel.Default {
                id: averageLabel

                font.bold: true
                font.pixelSize: 14

                color: Colors.uGrey

                text: "AVERAGE"

                anchors.horizontalCenter: averageValueContainer.horizontalCenter
                anchors.top: averageValueContainer.top

                anchors.topMargin: 25
            }

            ULabel.Default {
                id: averageValue

                font.bold: true
                font.pixelSize: 28

                color: Colors.uGreen
                text: getDeviceMeanValue()

                anchors.horizontalCenter: averageValueContainer.horizontalCenter
                anchors.bottom: averageValueContainer.bottom
                anchors.bottomMargin: 25
            }
        }

        Rectangle {
            id: lowestValueContainer

            anchors.left: averageValueContainer.right
            anchors.bottom: averageContainer.bottom
            anchors.top: averageContainer.top

            width: (averageContainer.width / 3)

            color: Colors.uTransparent

            ULabel.Default {
                id: lowestLabel

                font.bold: true
                font.pixelSize: 14

                color: Colors.uGrey

                text: "LOWEST"

                anchors.horizontalCenter: lowestValueContainer.horizontalCenter
                anchors.top: lowestValueContainer.top

                anchors.topMargin: 25
            }

            ULabel.Default {
                id: lowestValue

                font.bold: true
                font.pixelSize: 28

                color: Colors.uGreen
                text: getDeviceMinValue()

                anchors.horizontalCenter: lowestValueContainer.horizontalCenter
                anchors.bottom: lowestValueContainer.bottom
                anchors.bottomMargin: 25
            }
        }

        Rectangle {
            id: highestValueContianer

            anchors.left: lowestValueContainer.right
            anchors.bottom: averageContainer.bottom
            anchors.top: averageContainer.top

            width: (averageContainer.width / 3)

            color: Colors.uTransparent

            ULabel.Default {
                id: highestLabel

                font.bold: true
                font.pixelSize: 14

                color: Colors.uGrey

                text: "HIGHEST"

                anchors.horizontalCenter: highestValueContianer.horizontalCenter
                anchors.top: highestValueContianer.top

                anchors.topMargin: 25
            }

            ULabel.Default {
                id: highesValue

                font.bold: true
                font.pixelSize: 28

                color: Colors.uGreen
                text: getDeviceMaxValue()

                anchors.horizontalCenter: highestValueContianer.horizontalCenter
                anchors.bottom: highestValueContianer.bottom
                anchors.bottomMargin: 25
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
                chartName: "Daily status"
                chartData: getDeviceValueStats()
                width: chartContainer.width
                height: chartContainer.height
                chartType: Charts.ChartType.LINE
            }

            UI.UChart {
                id: powerChart
                chartAnimated: false
                chartName: "Power consumption"
                chartData: getDevicePowerStats()
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

        Component.onCompleted: {
            getDeviceMinValue();
        }
    }

    onModelChanged: {
        uCtrlApiFacade.getDeviceAllStats(devicesList.findObject(model.id));
    }

    function getDeviceEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
    }

    function getValue() {
        if (model !== null) return model.value
        else return 0
    }

    function getPrecision() {
        if (model !== null) return model.precision
        else return "0.1"
    }

    function getDeviceMinValue() {
       if (model !== null) return parseFloat(model.minStat).toFixed(1)
       else return "0";
    }

    function getDeviceMaxValue() {
        if (model !== null) return parseFloat(model.maxStat).toFixed(1)
        else return "0";
    }

    function getDeviceMeanValue() {
        if (model !== null) return parseFloat(model.meanStat).toFixed(1)
        else return "0";
    }

    function getDeviceValueStats() {
        if (model !== null) {

            /** Commented until server can handle statistics
                var data = []
                var labels = []

                for (var i=0; i<statsModel.rowCount();i++) {
                    var stat = statsModel.get(i);

                    //console.log("[" + new Date(stat.timestamp).toTimeString() + "] (" + stat.type +") :" + stat.data);
                    labels.push(new Date(stat.timestamp).toTimeString())
                    data.push(stat.data)
                }
            */

            var chartData = {
                "labels": ["06:10am","07:10am","08:10am","09:10am","10:10am","11:10am","12:10am"],
                "axisY": [0, 25, 50, 75, 100],
                "datasets": [{
                    fillColor: "rgba(237,237,237,0.5)",
                    strokeColor: Colors.uMediumLightGrey,
                    pointColor: Colors.uGreen,
                    pointStrokeColor: Colors.uGreen,
                    data: [0, 55, 15, 75, 100, 0, 50]
                }]
            }

            return chartData
        }
    }

    // Will always be hardcoded value since hardware no longer supports it.
    function getDevicePowerStats() {
        var chartData = {
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

        return chartData
    }
}
