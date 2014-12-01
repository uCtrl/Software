import QtQuick 2.0

import QtQuick.Controls 1.2

import "../../ui" as UI
import "../../label" as ULabel
import "../../ui/UColors.js" as Colors
import "./GraphHelper.js" as GraphHelper

import jbQuick.Charts 1.0
import "../../jbQuick/Charts/QChartGallery.js" as ChartsData

Rectangle {
    id: container

    property var model: null
    property var statsModel: null

    property string unitLabel : "°C"

    property bool displayStats: false

    Rectangle {
        id: valueContainer

        color: Colors.uTransparent

        height: (resourceLoader.loadResource("temperatureValuecontainerHeight"))
        width: (resourceLoader.loadResource("temperatureValuecontainerWidth"))

        anchors.top: container.top
        anchors.topMargin: 5

        anchors.left: container.left

        ULabel.Default {
            id: currentValueLabel

            text: "CURRENT VALUE"

            font.bold: true
            font.pixelSize: (resourceLoader.loadResource("temperatureValuecontainerCurrentValuelabelFontPixelSize"))

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
                font.pixelSize: (resourceLoader.loadResource("temperatureValuecontainerCurrentValuecontainerCurrentvalueFontPixelSize"))

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

                font.pixelSize: (resourceLoader.loadResource("temperatureValuecontainerUnitcontainerUnitlabelFontPixelSize"))

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

                font.pixelSize: (resourceLoader.loadResource("temperatureValuecontainerPrecisioncontainerPrecisionalabelFontPixelSize"))

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

        height: valueContainer.height
        width: (resourceLoader.loadResource("temperatureAveragecontainerWidth"))

        anchors.top: valueContainer.top
        anchors.bottom: valueContainer.bottom
        anchors.leftMargin: (resourceLoader.loadResource("temperatureAveragecontainerLeftmargin"))
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
                font.pixelSize: (resourceLoader.loadResource("temperatureAveragecontainerAveragelabelFontPixelSize"))

                color: Colors.uGrey

                text: "AVERAGE"

                anchors.horizontalCenter: averageValueContainer.horizontalCenter
                anchors.top: averageValueContainer.top

                anchors.topMargin: 25
            }

            ULabel.Default {
                id: averageValue

                font.bold: true
                font.pixelSize: (resourceLoader.loadResource("temperatureAveragecontainerAverageValueFontPixelSize"))

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
                font.pixelSize: (resourceLoader.loadResource("temperatureAveragecontainerAveragelabelFontPixelSize"))

                color: Colors.uGrey

                text: "LOWEST"

                anchors.horizontalCenter: lowestValueContainer.horizontalCenter
                anchors.top: lowestValueContainer.top

                anchors.topMargin: 25
            }

            ULabel.Default {
                id: lowestValue

                font.bold: true
                font.pixelSize: (resourceLoader.loadResource("temperatureAveragecontainerAverageValueFontPixelSize"))

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
                font.pixelSize: (resourceLoader.loadResource("temperatureAveragecontainerAveragelabelFontPixelSize"))

                color: Colors.uGrey

                text: "HIGHEST"

                anchors.horizontalCenter: highestValueContianer.horizontalCenter
                anchors.top: highestValueContianer.top

                anchors.topMargin: 25
            }

            ULabel.Default {
                id: highesValue

                font.bold: true
                font.pixelSize: (resourceLoader.loadResource("temperatureAveragecontainerAverageValueFontPixelSize"))

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
                chartData: {
                    "labels": [],
                    "datasets": [{
                        fillColor: "rgba(237,237,237,0.5)",
                        strokeColor: Colors.uMediumLightGrey,
                        pointColor: Colors.uGreen,
                        pointStrokeColor: Colors.uGreen,
                        data: []
                    }]
                }
                width: chartContainer.width
                height: chartContainer.height
                chartType: Charts.ChartType.LINE

                onChartDataChanged: refresh()
            }

            UI.UChart {
                id: powerChart
                chartAnimated: false
                chartName: "Power consumption"
                chartData: {
                    "labels": [],
                    "datasets": [{
                        fillColor: "rgba(237,237,237,0.5)",
                        strokeColor: Colors.uMediumLightGrey,
                        pointColor: Colors.uGreen,
                        pointStrokeColor: Colors.uGreen,
                        data: []
                    }]
                }
                width: chartContainer.width
                height: chartContainer.height
                chartType: Charts.ChartType.LINE

                onChartDataChanged: refresh()
            }

            visible: container.displayStats
        }

        Rectangle {
            id: noStats

            anchors.top: statsHeader.bottom
            anchors.bottom: carouselContainer.top

            clip: true
            width: parent.width

            color: Colors.uTransparent

            ULabel.Default {
                anchors.centerIn: parent

                font.bold: true
                font.pixelSize: 36

                color: Colors.uGrey

                text: "No stats to display"
            }

            visible: !container.displayStats
        }

        Rectangle {
            id: carouselContainer
            width: parent.width
            height: 60
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
            height: (resourceLoader.loadResource("temperatureStatsheaderHeight"))

            anchors.top: statsContainer.top

            UI.UFontAwesome {
                id: statsIcon
                iconId: "stats"
                iconSize: (resourceLoader.loadResource("temperatureStatsheaderStatsiconIconSize"))
                iconColor: Colors.uGrey
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }

            ULabel.Default {
                id: statsText
                text: "Statistics"
                anchors.left: statsIcon.right
                anchors.leftMargin: (resourceLoader.loadResource("temperatureStatsheaderStatstextLeftMargin"))
                color: Colors.uGrey
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
                font.pixelSize: (resourceLoader.loadResource("temperatureStatsheaderStatstextFontPixelSize"))
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

                height: (resourceLoader.loadResource("temperatureStatsheaderHeight"))
                width: (resourceLoader.loadResource("temperatureStatsheaderPeriodcomboWidth"))

                Component.onCompleted: selectItem(0)
                onSelectValue: updateStatsPeriod();

                z: 3
            }
        }
    }

    onModelChanged: {
        if (model) {
            statsModel = devicesList.getStatisticsWithId(model.id);
        }
    }

    onStatsModelChanged: {
        if (statsModel) {
            statsModel.setOnReceivedCallback(getDeviceValueStats);

            uCtrlApiFacade.getDeviceAllStats(devicesList.findObject(model.id),
                                             {"from": new Date().setMinutes(0, 0).toString(),
                                              "to": new Date().getTime().toString()});

        }
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
       if (model !== null) return model.minStat
       else return "0";
    }

    function getDeviceMaxValue() {
        if (model !== null) return model.maxStat
        else return "0";
    }

    function getDeviceMeanValue() {
        if (model !== null) return model.meanStat
        else return "0";
    }

    function getDeviceValueStats() {
        if (statsModel) {
            var period = periodCombo.selectedItem ? periodCombo.selectedItem.value : "hour";
            var chartData = GraphHelper.deviceValuesToChartData(statsModel, period);
            container.displayStats = (chartData.labels.length > 0);
            stateChart.chartData = {
                "labels": chartData.labels,
                "datasets": [{
                    fillColor: "rgba(237,237,237,0.5)",
                    strokeColor: Colors.uMediumLightGrey,
                    pointColor: Colors.uGreen,
                    pointStrokeColor: Colors.uGreen,
                    data: chartData.data
                }]
            }

            var powerData = []
            var powerLabel = []
            for(var i = 0; i < chartData.data.length; i++)
            {
                var value = 0;
                if(i == 0)
                    value = Math.random() * 10 + 1
                else
                    value = powerData[i-1] + Math.random() * 10 + 1

                powerData.push(value)
                powerLabel.push(chartData.labels[i])
            }

            var powerChartData = {
                labels: powerLabel,
                data: powerData
            }

            powerChart.chartData = {
                "labels": powerChartData.labels,
                "datasets": [{
                    fillColor: "rgba(237,237,237,0.5)",
                    strokeColor: Colors.uMediumLightGrey,
                    pointColor: Colors.uGreen,
                    pointStrokeColor: Colors.uGreen,
                    data: powerChartData.data
                }]
            }
        }
    }

    function updateStatsPeriod() {
        var period = periodCombo.selectedItem ? periodCombo.selectedItem.value : "hour";
        var params = GraphHelper.getDeviceValuesParams(period);
        uCtrlApiFacade.getDeviceValues(devicesList.findObject(model.id), {"from": params.from, "to": params.to, "interval": params.interval, "fn": "mean"});
    }
}
