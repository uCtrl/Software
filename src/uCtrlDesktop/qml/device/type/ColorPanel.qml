import QtQuick 2.0

import QtQuick.Controls 1.2
import QtGraphicalEffects 1.0

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

    property string unitLabel : ""
    property bool displayStats: false

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

            Rectangle
            {
                anchors.fill: parent
                color: getValue()
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
                               "labels": [],
                               "axisY": [0, 25, 50, 75, 100],
                               "datasets": [{
                                   fillColor: Colors.uGreen,
                                   strokeColor: Colors.uDarkGreen,
                                   pointColor: Colors.uGreen,
                                   pointStrokeColor: Colors.uGreen,
                                   data: [],
                               }]
                           }
                width: chartContainer.width
                height: chartContainer.height

                chartType: Charts.ChartType.BAR

                z: 2
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

    Rectangle {
        id: noStats

        anchors.left: container.left
        anchors.right: container.right
        anchors.top: valueContainer.bottom
        anchors.bottom: container.bottom

        clip: true
        width: parent.width
        visible: !container.displayStats

        color: Colors.uTransparent

        ULabel.Default {
            anchors.centerIn: parent

            font.bold: true
            font.pixelSize: 36

            color: Colors.uGrey

            text: "No stats to display"
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
        }
    }

    function getDeviceValueStats() {
        if (statsModel) {
            var period = periodCombo.selectedItem ? periodCombo.selectedItem.value : "hour";
            var chartData = GraphHelper.deviceValuesToChartData(statsModel, period);
            container.displayStats = (chartData.labels.length > 0);
            stateChart.chartData = {
                "labels": chartData.labels,
                "datasets": [{
                    fillColor: Colors.uGreen,
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
                var value = Math.random() * 2 + 1.5

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
        uCtrlApiFacade.getDeviceValues(devicesList.findObject(model.id), {"from": params.from.toString(), "to": params.to.toString(), "interval": params.interval, "fn": "count"});
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
