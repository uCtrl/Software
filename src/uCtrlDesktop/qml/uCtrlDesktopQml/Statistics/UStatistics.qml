import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel
import "../../jbQuick/Charts" as Charts

UI.UFrame {
    id: statsFrame

    contentItem: Rectangle {
        /*
        ULabel.Default {
            text: qsTr("Hello World !")
            color: _colors.uGreen
        }*/
/*
        Charts.Chart {

            chartType: BAR
        }*/

        Charts.QChartGallery {

        }
    }
}
