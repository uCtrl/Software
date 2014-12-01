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
        anchors.right: leftToRightSeparator.left

        anchors.margins: container.paddingSize

        height: 175

        UI.UFontAwesome {
            id: statusIcon

            anchors.top: statusContainer.top
            anchors.left: statusContainer.left

            anchors.margins: container.paddingSize

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

                            Rectangle {
                                color: modelData.color

                                height: 15; width: 15
                                radius: 2
                            }

                            ULabel.Default {

                                color: Colors.uBlack

                                font.bold: false
                                font.pixelSize: 10

                                text: modelData.title

                                width: 50
                            }

                            ULabel.Default {

                                color: modelData.color

                                font.bold: true
                                font.pixelSize: 10

                                text: modelData.value

                                width: 15
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
            id: typeGraphContainer

            anchors.top: typeTitleLabel.bottom
            anchors.topMargin: 10

            anchors.bottom: typeLegendContainer.top

            anchors.left: typeContainer.left
            anchors.leftMargin: 10

            anchors.right: typeContainer.right
            anchors.rightMargin: 10

            UI.UChart {
                id: deviceTypeChart

                anchors.fill: parent

                chartAnimated: false;
                chartData: container.deviceTypeData

                chartType: Charts.ChartType.POLAR;
            }
        }

        Rectangle {
            id: typeLegendContainer

            color: Colors.uTransparent

            anchors.bottom: typeContainer.bottom
            anchors.bottomMargin: 10

            anchors.left: typeContainer.left
            anchors.leftMargin: 10

            anchors.right: typeContainer.right
            anchors.rightMargin: 10

            height: 150

            ULabel.Default {
                id: typeLegendLabel

                text: "LEGEND"

                font.bold: false
                font.pixelSize: 12

                color: Colors.uGrey

                anchors.top: typeLegendContainer.top
                anchors.topMargin: 5

                anchors.horizontalCenter: typeLegendContainer.horizontalCenter
            }

            Row {

                anchors.top: typeLegendLabel.bottom
                anchors.topMargin: 10

                anchors.bottom: typeLegendContainer.bottom

                anchors.horizontalCenter: typeLegendContainer.horizontalCenter

                spacing: 20

                Repeater {
                    id: typeLegendColumnRepeater

                    model: getDeviceTypeLegend()

                    Column {
                        width: 150; height: (typeLegendContainer.height - typeLegendLabel.height)
                        spacing: 5
                        Repeater {
                            model: modelData
                            Row {
                                spacing: 5

                                Rectangle {
                                    color: modelData.color

                                    height: 15; width: 15
                                    radius: 2
                                }

                                ULabel.Default {

                                    color: Colors.uBlack

                                    font.bold: false
                                    font.pixelSize: 10

                                    text: modelData.title

                                    width: 95
                                }

                                ULabel.Default {

                                    color: modelData.color

                                    font.bold: true
                                    font.pixelSize: 10

                                    text: modelData.value

                                    width: 15
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    Rectangle {
        id: leftToRightSeparator
        width: 2

        anchors.top: container.top
        anchors.bottom: container.bottom

        anchors.margins: container.paddingSize

        x: ((container.width / 2) - width)

        color: Colors.uLightGrey
    }

    Rectangle {
        id: ambianceContainer

        anchors.top: container.top
        anchors.left: leftToRightSeparator.right
        anchors.right: container.right

        anchors.margins: container.paddingSize

        height: 45

        color: Colors.uTransparent

        UI.UFontAwesome {
            id: temperatureIcon

            anchors.top: ambianceContainer.top
            anchors.left: ambianceContainer.left

            anchors.margins: container.paddingSize

            iconId: "thermometer"
            iconSize: 26

            iconColor: Colors.uGreen
        }

        ULabel.Heading1 {
            id: temperatureTitleLabel

            anchors.left: temperatureIcon.right
            anchors.leftMargin: 27

            anchors.verticalCenter: temperatureIcon.verticalCenter

            text: "Home ambiance"
            font.bold: true

            color: Colors.uGreen
        }
    }

    Rectangle {
        id: temperatureContainer

        color: Colors.uTransparent

        anchors.top: ambianceContainer.bottom
        anchors.left: ambianceContainer.left
        anchors.right: ambianceContainer.right

        height: ((container.height - ambianceContainer.height) / 2)

        ULabel.Default {
            id: temperatureLabel

            font.bold: false
            font.pixelSize: 10

            color: Colors.uMediumDarkGrey

            text: "HOME TEMPERATURE"

            anchors.left: temperatureContainer.left
            anchors.top: temperatureContainer.top
        }

        Rectangle {
            id: currentValueContainer

            color: Colors.uTransparent

            anchors.left: temperatureLabel.left
            anchors.top: temperatureLabel.bottom

            height: 75; width: 150

            ULabel.Default {
                id: currentValue

                text: getTemperatureValue()

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

            anchors.left: currentValueContainer.right
            width: 30

            anchors.top: currentValueContainer.top
            height: (currentValueContainer.height / 2)

            ULabel.Default {
                id: unitLabel

                font.pixelSize: 20

                text: "°C"

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

                text: "±0." + getTemperaturePrecision()

                color: Colors.uGrey

                anchors.top: precisionContainer.precisionContainer
                anchors.left: precisionContainer.left
            }
        }

        Rectangle {
            id: thermometerStats

            anchors.top: currentValueContainer.top
            anchors.bottom: precisionContainer.bottom

            anchors.left: precisionContainer.right
            anchors.right: temperatureContainer.right

            color: Colors.uTransparent

            Column {
                id: temperatureStatsColumn

                anchors.top: thermometerStats.top
                anchors.topMargin: 10

                anchors.left: thermometerStats.left
                anchors.leftMargin: 25

                spacing: 2

                Repeater {
                    id: temperatureRepeater

                    model: getThermometerSensorStats()
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

                            height: 17; width: 40;

                            boundedTextSize: 10
                            boundedColor: Colors.uWhite
                            boundedTextColor: Colors.uGreen

                            text: modelData.value
                        }
                    }
                }
            }
        }

        Rectangle {
            id: temperatureGraphContainer

            color: Colors.uTransparent

            anchors.top: thermometerStats.bottom
            anchors.bottom: temperatureContainer.bottom

            anchors.left: temperatureContainer.left
            anchors.right: temperatureContainer.right

            UI.UChart {
                id: temperatureChart

                anchors.fill: parent

                chartAnimated: false;
                chartData: getThermometerStats()

                chartType: Charts.ChartType.LINE;
            }
        }
    }

    Rectangle {
        id: humidityContainer

        color: Colors.uTransparent

        anchors.top: temperatureContainer.bottom
        anchors.bottom: container.bottom

        anchors.left: ambianceContainer.left
        anchors.right: ambianceContainer.right

        ULabel.Default {
            id: humidityLabel

            font.bold: false
            font.pixelSize: 10

            color: Colors.uMediumDarkGrey

            text: "HOME HUMIDITY"

            anchors.left: humidityContainer.left
            anchors.top: humidityContainer.top
        }

        Rectangle {
            id: currentHumidityContainer

            color: Colors.uTransparent

            anchors.left: humidityLabel.left
            anchors.top: humidityLabel.bottom

            height: 75; width: 150

            ULabel.Default {
                id: currentHumidity

                text: getHumidityValue()

                font.bold: true
                font.pixelSize: 68

                color: Colors.uMediumDarkGrey

                anchors.right: currentHumidityContainer.right
                anchors.verticalCenter: currentHumidityContainer.verticalCenter
            }
        }

        Rectangle {
            id: humidityUnitContainer

            color: Colors.uTransparent

            anchors.left: currentHumidityContainer.right
            width: 30

            anchors.top: currentHumidityContainer.top
            height: (currentHumidityContainer.height / 2)

            ULabel.Default {
                id: humidityUnitLabel

                font.pixelSize: 20

                text: "%"

                color: Colors.uGrey

                anchors.bottom: humidityUnitContainer.bottom
                anchors.left: humidityUnitContainer.left
            }
        }

        Rectangle {
            id: humidityPrecisionContainer

            color: Colors.uTransparent

            anchors.left: humidityUnitContainer.left
            anchors.right: humidityUnitContainer.right
            anchors.top: humidityUnitContainer.bottom
            height: humidityUnitContainer.height

            ULabel.Default {
                id: humidityPrecisionLabel

                font.pixelSize: 12

                text: "±0." + getHumidityPrecision()

                color: Colors.uGrey

                anchors.top: humidityPrecisionContainer.precisionContainer
                anchors.left: humidityPrecisionContainer.left
            }
        }

        Rectangle {
            id: humidityStats

            anchors.top: currentHumidityContainer.top
            anchors.bottom: humidityPrecisionContainer.bottom

            anchors.left: humidityPrecisionContainer.right
            anchors.right: humidityContainer.right

            color: Colors.uTransparent

            Column {
                id: humdityStatsColumn

                anchors.top: humidityStats.top
                anchors.topMargin: 10

                anchors.left: humidityStats.left
                anchors.leftMargin: 25

                spacing: 2

                Repeater {
                    id: humidityRepeater

                    model: getHumiditySensorStats()
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

                            height: 17; width: 40;

                            boundedTextSize: 10
                            boundedColor: Colors.uWhite
                            boundedTextColor: Colors.uGreen

                            text: modelData.value
                        }
                    }
                }
            }
        }

        Rectangle {
            id: humidityGraphContainer

            color: Colors.uTransparent

            anchors.top: humidityStats.bottom
            anchors.bottom: humidityContainer.bottom

            anchors.left: humidityContainer.left
            anchors.right: humidityContainer.right

            UI.UChart {
                id: humidityChart

                anchors.fill: parent

                chartAnimated: false;
                chartData: getThermometerStats()

                chartType: Charts.ChartType.LINE;
            }
        }

    }

    Component.onCompleted: {
        getDeviceStatusData();
        getDeviceTypeData();

        uCtrlApiFacade.getOverallMax({"type": 31})
    }

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

    function getDeviceTypeData() {

        // @TODO Complete with real data.
        container.deviceTypeData = [{value: 22, title: "Power Switch Socket", color: Colors.uGreen },
                                    {value: 43, title: "Push Button", color: Colors.uYellow },
                                    {value: 12, title: "Motion Sensor", color: Colors.uRed },
                                    {value: 18, title: "Humidity", color: Colors.uBlue },
                                    {value: 16, title: "Temperature", color: Colors.uPink },
                                    {value: 42, title: "Ninja Eyes", color: Colors.uPurple },
                                    {value: 15, title: "Dimmer Light", color: Colors.uOrange },
                                    {value: 25, title: "Door sensor", color: Colors.uCyan },
                                    {value: 12, title: "Light sensor", color: Colors.uLime }]

    }

    function getThermometerStats() {
        // @TODO Complete with real data.

        return {
            "labels": ["A", "B", "C", "D", "E", "F"],
            "datasets": [{
                fillColor: "rgba(237,237,237,0.5)",
                strokeColor: Colors.uMediumLightGrey,
                pointColor: Colors.uGreen,
                pointStrokeColor: Colors.uGreen,
                data: [21, 20, 18, 22, 23, 25]
            }]
        }
    }

    function getThermometerSensorStats() {

        // @TODO Complete with real data.
        return [{"label": "Sensor detected", "value": 4},
                {"label": "Lowest value", "value": 16.5},
                {"label": "Highest value", "value": 25.4}]
    }

    function getDeviceTypeLegend() {
        if (container.deviceTypeData === []) return []
        else {
            var length = (container.deviceTypeData.length > 1 ? ((container.deviceTypeData.length / 2) + 1) : 1)
            return [container.deviceTypeData.slice(0, length), container.deviceTypeData.slice(length)]
        }
    }

    function getTemperatureValue() {
        // @TODO Complete with real data.
        return "23.1"
    }

    function getTemperaturePrecision() {
        // @TODO Complete with real data.
        return '1'
    }

    function getHumiditySensorStats() {

        // @TODO Complete with real data.
        return [{"label": "Sensor detected", "value": 4},
                {"label": "Lowest value", "value": 16.5},
                {"label": "Highest value", "value": 25.4}]
    }

    function getHumidityValue() {
        // @TODO Complete with real data.
        return "73.4"
    }

    function getHumidityPrecision() {
        // @TODO Complete with real data.
        return '1'
    }
}
