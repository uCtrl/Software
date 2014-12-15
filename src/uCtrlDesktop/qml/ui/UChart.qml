import QtQuick 2.0

import "../jbQuick/Charts/" as UCharts

UCharts.QChart {
    id: chart
    property string chartName: "UNKNOWN"

    NumberAnimation
    {
        id: enterLeftChart;
        target: chart;
        properties: "x";
        from: -chart.width;
        to: 0;
        duration: 1000;
        easing.type: Easing.InOutQuad
    }

    NumberAnimation
    {
        id: enterRightChart;
        target: chart;
        properties: "x";
        from: chart.width;
        to: 0;
        duration: 1000;
        easing.type: Easing.InOutQuad
    }

    NumberAnimation
    {
        id: exitLeftChart;
        target: chart;
        properties: "x";
        from: 0;
        to: -chart.width;
        duration: 1000;
        easing.type: Easing.InOutQuad
    }

    NumberAnimation
    {
        id: exitRightChart;
        target: chart;
        properties: "x";
        from: 0;
        to: chart.width;
        duration: 1000;
        easing.type: Easing.InOutQuad
    }

    function enterLeft()
    {
        enterLeftChart.start()
    }

    function enterRight()
    {
        enterRightChart.start()
    }

    function exitLeft()
    {
        exitLeftChart.start()
    }

    function exitRight()
    {
        exitRightChart.start()
    }
}
