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

    property bool displayStats: false

    color: Colors.uTransparent

    anchors.fill: parent

    Rectangle {
        id: slideContainer

        color: Colors.uTransparent

        anchors.top: container.top
        anchors.left: container.left
        anchors.right: container.right

        ULabel.IconLabel {
            id: manualCommandHeader

            iconId: "info"
            text: "Current value"
            width: parent.width

            iconLabelSize: 11
            iconSize: 11

            anchors.top: slideContainer.top
            anchors.left: slideContainer.left

            iconLabelColor: Colors.uGrey
        }

        UI.USlider {
            id: currentValueSlider

            anchors.top: manualCommandHeader.bottom
            anchors.bottom: slideContainer.bottom
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.right: slideContainer.right

            minimumValue: 0
            maximumValue: 100

            value: getOpacity() * 100

            stepSize: 5

            onNewValue: saveForm(value)

        }

        height: 75
    }

    Rectangle {
        id: statsContainer

        anchors.top: slideContainer.bottom
        anchors.bottom: container.bottom
        anchors.left: container.left
        anchors.right: container.right

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
                        fillColor: Colors.uBlack,
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
                        fillColor: Colors.uBlack,
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
                onSelectValue: updateStatsPeriod();

                z: 3
            }
        }
    }

    onModelChanged: {
        if (model) {
            container.statsModel = devicesList.getStatisticsWithId(model.id);
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

    function getOpacity() {
        if (model !== null & model !== undefined) return model.value;
        else return 1;
    }

    function saveForm(newValue) {
        if (model.value !== newValue) model.value = (newValue / 100);
        uCtrlApiFacade.putDevice(devicesList.findObject(model.id));
    }

    function getDeviceValueStats() {
        if (container.statsModel)
        {
            var period = periodCombo.selectedItem ? periodCombo.selectedItem.value : "hour";
            var chartData = GraphHelper.deviceValuesToChartData(container.statsModel, period);

            container.displayStats = (chartData.data.length > 0);
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
                var value = Math.random() * 10 + 1

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
