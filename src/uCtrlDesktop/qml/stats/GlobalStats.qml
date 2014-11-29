import QtQuick 2.0

import "../ui/UColors.js" as Colors
import "../ui" as UI
import "../label" as ULabel

import jbQuick.Charts 1.0

Rectangle {
    id: container

    color: Colors.uWhite

    property int paddingSize: 15

    property var deviceStatusData: []
    property var deviceTypeData: []

    anchors.fill: parent
    anchors.margins: paddingSize

    radius: 8

    Rectangle {
        id: statusContainer

        color: Colors.uTransparent

        anchors.top: container.top
        anchors.left: container.left

        height: 175; width: (container.width / 2);

        UI.UFontAwesome {
            id: statusIcon

            anchors.top: statusContainer.top
            anchors.left: statusContainer.left

            anchors.margins: (container.paddingSize * 2)

            iconId: "ToggleOn"
            iconSize: 26

            iconColor: getSystemStatusColor()
        }

        ULabel.Heading1 {
            id: statusTitleLabel

            anchors.left: statusIcon.right
            anchors.leftMargin: 27

            anchors.verticalCenter: statusIcon.verticalCenter

            text: "System status"
            font.bold: true

            color: getSystemStatusColor()
        }

        ULabel.UInfoBoundedLabel {
            id: systemStatusValue

            anchors.right: statusContainer.right
            anchors.rightMargin: 15

            anchors.verticalCenter: statusIcon.verticalCenter
            height: 25; width: 60;

            boundedTextSize: 13

            text: getSystemStatus()
            color: getSystemStatusColor()
        }

        Column {
            id: overviewColumn

            anchors.top: statusTitleLabel.bottom
            anchors.topMargin: 10

            anchors.left: statusContainer.left
            anchors.leftMargin: 15

            spacing: 5

            Repeater {
                id: overviewRepeater

                model: getOverviewStats()
                Row {
                    spacing: 2

                    ULabel.Default {
                        text: modelData.label

                        anchors.verticalCenter: parent.verticalCenter

                        width: 120

                        font.bold: false
                        font.pixelSize: 11

                        color: Colors.uBlack
                    }

                    ULabel.UInfoBoundedLabel {

                        height: 20; width: 40;

                        boundedTextSize: 10
                        boundedColor: Colors.uWhite
                        boundedTextColor: Colors.uGreen

                        text: modelData.value
                    }
                }
            }
        }

        Rectangle {
            id: statusChartContainer

            color: Colors.uWhite

            height: overviewColumn.height; width: height

            anchors.right: statusContainer.right
            anchors.verticalCenter: overviewColumn.verticalCenter

            UI.UChart {
                id: deviceStatusChart

                anchors.fill: parent

                chartAnimated: false;
                chartData: container.deviceStatusData

                chartType: Charts.ChartType.PIE;
            }

            Rectangle {
                id: statusLegendContainer

                anchors.top: statusChartContainer.top
                anchors.bottom: statusChartContainer.bottom

                anchors.right: statusChartContainer.left
                width: 150

                color: Colors.uTransparent

                ULabel.Default {
                    id: legendLabel

                    text: "100 DEVICES DETECTED"

                    font.bold: false
                    font.pixelSize: 9

                    color: Colors.uGrey

                    anchors.top: statusLegendContainer.top
                    anchors.horizontalCenter: statusLegendContainer.horizontalCenter
                }

                Column {
                    id: legendColumn

                    anchors.top: legendLabel.bottom
                    anchors.topMargin: 5

                    anchors.bottom: statusLegendContainer.bottom
                    anchors.right: statusLegendContainer.right
                    anchors.left: statusLegendContainer.left

                    width: 75
                    spacing: 2

                    Repeater {
                        model: container.deviceStatusData

                        Row {
                            anchors.horizontalCenter: legendColumn.horizontalCenter

                            spacing: 15
                            ULabel.Default {

                                color: modelData.color

                                font.bold: true
                                font.pixelSize: 10

                                text: modelData.value

                                width: 15
                            }

                            ULabel.Default {

                                color: Colors.uBlack

                                font.bold: false
                                font.pixelSize: 10

                                text: modelData.title

                                width: 50
                            }

                            Rectangle {
                                color: modelData.color

                                height: 15; width: 15
                                radius: 2
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {

        id: typeContainer

        color: Colors.uTransparent

        anchors.top: statusContainer.bottom
        anchors.bottom: container.bottom

        anchors.left: container.left
        width: statusContainer.width

        UI.UFontAwesome {
            id: typeIcon

            anchors.top: typeContainer.top
            anchors.left: typeContainer.left

            anchors.margins: (container.paddingSize * 2)

            iconId: "tags"
            iconSize: 26

            iconColor: Colors.uGreen
        }

        ULabel.Heading1 {
            id: typeTitleLabel

            anchors.left: typeIcon.right
            anchors.leftMargin: 27

            anchors.verticalCenter: typeIcon.verticalCenter

            text: "Device type distribution"
            font.bold: true

            color: Colors.uGreen
        }

        Rectangle {
            id: typeLegendContainer

            color: "cyan"

            anchors.top: typeTitleLabel.bottom
            anchors.topMargin: 10

            anchors.left: typeContainer.left
            anchors.right: typeContainer.right

            height: 100
        }

        Rectangle {
            id: typeGraphContainer

            anchors.top: typeLegendContainer.bottom
            anchors.left: typeContainer.left
            anchors.right: typeContainer.right
            anchors.bottom: typeContainer.bottom

            color: "pink"
        }
    }

    Component.onCompleted: getDeviceStatusData()

    function getSystemStatus() {
        // @TODO Complete with real data.
        return "ONLINE"
    }

    function getSystemStatusColor() {
        switch(getSystemStatus()) {
        case "ONLINE":
            return Colors.uGreen;
        case "OFFLINE":
            return Colors.uRed;
        default:
            return Colors.uGrey;
        }
    }

    function getOverviewStats() {

        // @TODO Complete with real data.

        return [{"label": "Platforms detected", "value": 2},
                {"label": "Devices detected", "value": 100},
                {"label": "Active scenarios", "value": 270},
                {"label": "Active tasks", "value": 680}]
    }

    function getDeviceStatusData() {

        // @TODO Complete with real data.
        container.deviceStatusData = [{ value: 30, title: "OK", color: Colors.uGreen  },
                                      { value: 15, title: "WARNING", color: Colors.uYellow },
                                      { value: 5, title: "ERROR", color: Colors.uRed    }]
    }
}
