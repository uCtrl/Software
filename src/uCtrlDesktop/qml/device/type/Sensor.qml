import QtQuick 2.0

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

    property bool hideButton: false

    property bool displayStats: false
    color: Colors.uTransparent

    Rectangle {
        id: buttonContainer

        anchors.top: container.top
        anchors.left: container.left
        anchors.right: container.right

        color: Colors.uTransparent

        UI.UButton {
            property int marginSize: 5

            id: triggerButton

            iconId: "Upload"
            text: "Send action"

            anchors.centerIn: buttonContainer

            width: 200
            height: buttonContainer.height - (2 * marginSize)

            onClicked: sendAction()
        }

        visible: !container.hideButton

        width: 200
        height: 45
    }

    Rectangle {
        id: updateContainer

        color: Colors.uTransparent

        anchors.left: container.left
        anchors.right: container.right

        anchors.top: (container.hideButton ? container.top : buttonContainer.bottom)
        height: 35

        UI.UFontAwesome {
            id: updateIcon

            iconId: "earth"
            iconSize: 12
            iconColor: Colors.uGrey

            anchors.left: updateContainer.left
            anchors.leftMargin: 10
            anchors.verticalCenter: updateContainer.verticalCenter
        }

        ULabel.Default {
            id: updateLabel

            text: "Last detection : " + getLastUpdatedText()

            font.bold: false
            font.pixelSize: 11

            color: Colors.uGrey

            anchors.left: updateIcon.right
            anchors.leftMargin: 15

            anchors.verticalCenter: updateContainer.verticalCenter
        }
    }

    Rectangle {
        id: graphContainer

        color: Colors.uTransparent

        anchors.left: container.left
        anchors.right: container.right

        anchors.top: updateContainer.bottom
        anchors.bottom: container.bottom

        Rectangle {
            id: graphHeader

            color: Colors.uTransparent

            anchors.left: graphContainer.left
            anchors.right: graphContainer.right
            anchors.top: graphContainer.top

            height: 25

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
                font.bold: false
                font.pixelSize: 11
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

                Component.onCompleted: selectItem(0);
                onSelectValue: updateStatsPeriod();

                z: 3
            }

            z: 2
        }

        Rectangle {
            id: graph

            color: Colors.uTransparent

            anchors.left: graphContainer.left
            anchors.right: graphContainer.right
            anchors.top: graphHeader.bottom
            anchors.bottom: carouselContainer.top

            visible: container.displayStats
            clip: true

            UI.UChart {
                id: stateChart
                chartAnimated: false
                chartName: "Daily status"
                chartData: {
                    "labels": [],
                    "datasets": [{
                        fillColor: Colors.uGreen,
                        strokeColor: Colors.uMediumLightGrey,
                        pointColor: Colors.uGreen,
                        pointStrokeColor: Colors.uGreen,
                        data: []
                    }]
                }
                width: graph.width
                height: graph.height
                chartType: Charts.ChartType.BAR

                onChartDataChanged: refresh()
            }

            UI.UChart {
                id: powerChart
                chartAnimated: false
                chartName: "Power consumption"
                chartData: {"labels": ["06:10am","07:10am","08:10am","09:10am","10:10am","11:10am","12:10am"],
                           "datasets": [{
                               fillColor: "rgba(237,237,237,0.5)",
                               strokeColor: Colors.uMediumLightGrey,
                               pointColor: Colors.uGreen,
                               pointStrokeColor: Colors.uGreen,
                               data: [0, 15, 20, 23, 25, 60, 67]
                           }]
                       }
                width: graph.width
                height: graph.height
                chartType: Charts.ChartType.LINE

                z: 2
            }

            z: 1
        }

        Rectangle {
            id: noStats

            anchors.left: graphContainer.left
            anchors.right: graphContainer.right
            anchors.top: graphHeader.bottom
            anchors.bottom: carouselContainer.top

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

    function getLastUpdatedText() {
        if (model !== null && model.lastUpdate !== undefined) return model.lastUpdate
        else return " A second ago."
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
        }
    }

    function updateStatsPeriod() {
        var period = periodCombo.selectedItem ? periodCombo.selectedItem.value : "hour";
        var params = GraphHelper.getDeviceValuesParams(period);
        uCtrlApiFacade.getDeviceValues(devicesList.findObject(model.id), {"from": params.from.toString(), "to": params.to.toString(), "interval": params.interval, "fn": "count"});
    }

    function sendAction() {
        model.value = true
        uCtrlApiFacade.putDevice(devicesList.findObject(model.id))
    }
}
