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
    property var statsModel: null

    property bool displayStats: true

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

        Rectangle {
            id: currentValueContainer

            anchors.left: slideContainer.left
            anchors.top: manualCommandHeader.bottom
            anchors.bottom: slideContainer.bottom

            width: 75

            ULabel.Default {
                anchors.centerIn: currentValueContainer

                font.bold: true
                font.pixelSize: 24

                color: Colors.uGrey

                text: (getOpacity() * 100) + "%"
            }
        }

        UI.USlider {
            id: currentValueSlider

            anchors.top: manualCommandHeader.bottom
            anchors.bottom: slideContainer.bottom
            anchors.left: currentValueContainer.right
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
                chartData: getDevicePowerStats()
                width: chartContainer.width
                height: chartContainer.height
                chartType: Charts.ChartType.LINE
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
                    { value: "hour", displayedValue: "This hour", iconId: ""},
                    { value: "today",     displayedValue: "Today", iconId: ""},
                    { value: "month",   displayedValue: "This month", iconId: ""},
                    { value: "year", displayedValue: "This year", iconId: ""}
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
        uCtrlApiFacade.getDeviceAllStats(devicesList.findObject(model.id),
                                         {"from": new Date().setMinutes(0, 0).toString(),
                                          "to": new Date().getTime().toString()});

        container.statsModel = devicesList.getStatisticsWithId(model.id);
        container.statsModel.setOnReceivedCallback(getDeviceValueStats);
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
        if (model !== null) {

            var data = []
            var labels = []

            for (var i=0; i<statsModel.rowCount;i++) {
                var stat = statsModel.get(i);

                if (!isNaN(stat.data)) {
                    labels.push(new Date(stat.timestamp).toTimeString())
                    data.push(Number(stat.data))
                }
            }

            container.displayStats = (data.length > 0)

            var chartData = {
                "labels": labels,
                "datasets": [{
                    fillColor: "rgba(237,237,237,0.5)",
                    strokeColor: Colors.uMediumLightGrey,
                    pointColor: Colors.uGreen,
                    pointStrokeColor: Colors.uGreen,
                    data: data
                }]
            }

            stateChart.chartData = chartData;
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

    function updateStatsPeriod() {

        if (periodCombo.selectedItem !== null) var period = periodCombo.selectedItem.value
        else period = "hour"

        var from = ""
        var to = ""
        var interval = ""

        switch (period) {
        case "hour":
            from = new Date().setMinutes(0, 0)
            interval = "15min"
            break;
        case "today":
            from = new Date().setHours(0, 0, 0)
            interval = "1hour"
            break;
        case "month":
            from = new Date().setDate(1, 0, 0, 0)
            interval = "12hour"
            break;
        case "year":
            from = new Date().setMonth(0, 1, 0, 0, 0)
            interval = "1month"
            break;
        }
        to = new Date().getTime()

        uCtrlApiFacade.getDeviceValues(devicesList.findObject(model.id), {"from": from.toString(), "to": to.toString(), "interval": interval, "fn": "mean"});
    }
}
