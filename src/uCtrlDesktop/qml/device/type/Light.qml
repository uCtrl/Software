import QtQuick 2.0

import "../../ui/UColors.js" as Colors
import "../../label" as ULabel
import "../../ui" as UI
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import "../../jbQuick/Charts/" as UCharts
import "../../jbQuick/Charts/QChart.js" as Charts

Rectangle {
    id: container
    anchors.centerIn: parent
    color: Colors.uTransparent

    Rectangle
    {
        id: statusContainer
        width: parent.width * 0.5
        height: parent.height * 0.5

        color: Colors.uTransparent

        ULabel.IconLabel
        {
            id: statusHeader
            iconId: "info"
            text: "Information"
            width: parent.width
        }

        Rectangle
        {
            id: statusContentContainer
            width: parent.width
            height: parent.height - statusHeader.height
            anchors.bottom: parent.bottom

            color: Colors.uTransparent
            Column
            {
                id: infoLayout
                anchors.fill: parent
                property int headerColumnWidth: 100
                property int valueColumnWidth: width - headerColumnWidth
                property int rowHeight: 20

                Rectangle
                {
                    width: parent.width
                    height: infoLayout.rowHeight
                    color: Colors.uTransparent

                    ULabel.Default
                    {
                        text: "Luminosité"
                        font.bold: true
                        width: infoLayout.headerColumnWidth
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ULabel.Default
                    {
                        text: "50%"

                        width: infoLayout.valueColumnWidth
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                    }
                }

                Rectangle
                {
                    width: parent.width
                    height: infoLayout.rowHeight
                    color: Colors.uTransparent

                    ULabel.Default
                    {
                        text: "Type"
                        font.bold: true
                        width: infoLayout.headerColumnWidth
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ULabel.Default
                    {
                        text: "Lumière (gradateur)"

                        width: infoLayout.valueColumnWidth
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                    }
                }
                Rectangle
                {
                    width: parent.width
                    height: infoLayout.rowHeight
                    color: Colors.uTransparent

                    ULabel.Default
                    {
                        text: "Modèle"
                        font.bold: true
                        width: infoLayout.headerColumnWidth
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ULabel.Default
                    {
                        text: "KZb8220T"

                        width: infoLayout.valueColumnWidth
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                    }
                }
                Rectangle
                {
                    width: parent.width
                    height: infoLayout.rowHeight
                    color: Colors.uTransparent

                    ULabel.Default
                    {
                        text: "GUID"
                        font.bold: true
                        width: infoLayout.headerColumnWidth
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ULabel.Default
                    {
                        text: "ffff1bce-543b-465c-891d-0c690a5f0925"

                        width: infoLayout.valueColumnWidth
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                    }
                }
                Rectangle
                {
                    width: parent.width
                    height: infoLayout.rowHeight
                    color: Colors.uTransparent

                    ULabel.Default
                    {
                        text: "Power"
                        font.bold: true
                        width: infoLayout.headerColumnWidth
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ULabel.Default
                    {
                        text: "120 W"

                        width: infoLayout.valueColumnWidth
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                    }
                }
                Rectangle
                {
                    width: parent.width
                    height: infoLayout.rowHeight
                    color: Colors.uTransparent

                    ULabel.Default
                    {
                        text: "Lifespan"
                        font.bold: true
                        width: infoLayout.headerColumnWidth
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    ULabel.Default
                    {
                        text: "3 months"

                        width: infoLayout.valueColumnWidth
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        elide: Text.ElideRight
                        wrapMode: Text.NoWrap
                    }
                }
            }
        }
    }

    Rectangle
    {
        id: manualCommandContainer
        width: parent.width * 0.5
        height: parent.height * 0.5
        anchors.right: parent.right

        color: Colors.uTransparent

        ULabel.IconLabel
        {
            id: manualCommandHeader
            iconId: "Cog"
            text: "Commande manuelle"
            width: parent.width
        }

        Rectangle
        {
            id: manualCommandContentContainer
            width: parent.width
            height: parent.height - statusHeader.height
            anchors.bottom: parent.bottom

            color: Colors.uTransparent

            Column
            {
                anchors.fill: parent
                Rectangle
                {
                    height: infoLayout.rowHeight
                    width: parent.width
                    UI.USlider
                    {
                        minimumValue: 0
                        maximumValue: 100
                        value: 50
                        stepSize: 5
                        width: parent.width
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
        }
    }

    Rectangle
    {
        id: statsContainer
        width: parent.width
        height: parent.height * 0.5
        anchors.bottom: parent.bottom

        color: Colors.uTransparent

        Rectangle
        {
            id: statsContentContainer
            width: parent.width
            height: parent.height - statusHeader.height
            anchors.bottom: parent.bottom
            UCharts.QChart {
                chartAnimated: true
                chartData: {
                               "labels": ["06:10am","07:10am","08:10am","09:10am","10:10am","11:10am","12:10am"],
                               "datasets": [{
                                   fillColor: "rgba(237,237,237,0.5)",
                                   strokeColor: Colors.uMediumLightGrey,
                                   pointColor: Colors.uGreen,
                                   pointStrokeColor: Colors.uGreen,
                                   data: [50,0,0,75,66,43,100]
                               }]
                           }
                anchors.fill: parent
                chartType: Charts.ChartType.LINE
            }

            color: Colors.uTransparent
        }

        ULabel.IconLabel
        {
            id: statsHeader
            iconId: "stats"
            text: "Statistiques"
            width: parent.width

            UI.UCombobox
            {
                anchors.left: parent.left
                anchors.leftMargin: 125
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height - 4
                width: 125
                z: 1

                property variant periods: [
                    { value: "today",  displayedValue: "Today",      iconId: ""},
                    { value: "week",   displayedValue: "This week",  iconId: ""},
                    { value: "month",  displayedValue: "This month", iconId: ""},
                ]

                itemListModel: periods

                Component.onCompleted: selectItem(0)
            }
        }

    }
}
