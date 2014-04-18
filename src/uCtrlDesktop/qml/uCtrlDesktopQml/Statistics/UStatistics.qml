import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel
import "../../jbQuick/Charts" as Charts

UI.UFrame {
    id: statsFrame
    height: parent.height
    width: parent.width

    contentItem: Rectangle {
        Charts.QChartGallery {
            height: statsFrame.height
            width: statsFrame.width
        }
    }
}
