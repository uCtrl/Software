import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

import "./type" as Type

import DeviceEnums 1.0
import HistoryEnums 1.0

ListView {
    property var logsModel: []
    id: historyLogs

    anchors.fill: parent

    model: logsModel

    property variant currentItem: null

    delegate: Column {
        id: column

        width: parent.width
        Rectangle
        {
            width: parent.width
            height: 50

            color: getBackgroundColor(model)
            anchors.leftMargin: -5
            anchors.rightMargin: -5
            radius: 5

            Rectangle
            {
                id: content
                width: parent.width - 20
                height: parent.height - 4
                anchors.centerIn: parent
                color: Colors.uTransparent

                Rectangle
                {
                    id: eventHeader

                    width: 140
                    height: parent.height - 10
                    anchors.verticalCenter: parent.verticalCenter
                    radius: 5

                    color: getBoundingColor(model)

                    ULabel.Default
                    {
                        id: eventHeaderLabel

                        color: Colors.uWhite
                        font.pointSize: 16
                        font.bold: true

                        text: getHeaderText(model)

                        anchors.centerIn: parent
                    }
                }

                Rectangle
                {
                    id: eventDescription

                    anchors.left: eventHeader.right
                    anchors.leftMargin: 10
                    anchors.right: eventTimestamp.left
                    height: parent.height
                    color: Colors.uTransparent

                    Rectangle
                    {
                        id: eventDescriptionIcon
                        visible: model.type === UELogType.Update

                        width: model.type === UELogType.Update ? parent.height : 0
                        height: parent.height
                        color: Colors.uTransparent

                        UI.UFontAwesome
                        {
                            iconColor: Colors.uGrey
                            iconId: "earth"
                            iconSize: 18
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle
                    {
                        anchors.left: eventDescriptionIcon.right
                        anchors.right: parent.right
                        height: parent.height
                        color: Colors.uTransparent

                        ULabel.Default
                        {
                            text: model.message
                            width: parent.width
                            anchors.verticalCenter: parent.verticalCenter
                            color: Colors.uGrey
                        }
                    }
                }
                Rectangle
                {
                    id: eventTimestamp
                    width: parent.width * 0.25
                    height: parent.height
                    anchors.right: parent.right
                    color: Colors.uTransparent

                    ULabel.Default
                    {
                        text: getTimestampLabel(model.timestamp)
                        font.italic: true
                        font.pointSize: 10
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.right: parent.right
                        color: Colors.uGrey
                    }
                }

            }
        }
    }

    function getTimestampLabel(timestamp)
    {
        var nowDate = new Date()
        var timestampDate = new Date(timestamp);
        var nowTimestamp = nowDate.getTime()

        var deltaTime = Math.abs(nowTimestamp - timestamp)

        var minute = 60
        var hour = 60 * minute
        var day = 24 * hour
        var week = 7 * day

        if(deltaTime < minute)
        {
            return "Less than a minute ago"
        }
        else if(nowDate.getDate() === timestampDate.getDate())
        {
            return "Today at " + Qt.formatDateTime(timestampDate, "HH:mm:ss")
        }
        else if(nowDate.getDate() - 1 === timestampDate.getDate())
        {
            return "Yesterday at " + Qt.formatDateTime(timestampDate, "HH:mm:ss")
        }
        else
        {
            return Qt.formatDateTime(timestampDate, "dd-MM-YYYY HH:mm")
        }
    }

    function getBackgroundColor(model)
    {
        return model.type === UELogType.Update ? Colors.uLightGrey : Colors.uTransparent
    }

    function getHeaderText(model)
    {
        switch(model.type)
        {
            case UELogType.Action:
                return "Action"
            case UELogType.Scenario:
                return "Scenario"
            case UELogType.Condition:
                return "Condition"
            case UELogType.Update:
                return "Update"
            case UELogType.Status:
                return "Status"
            default:
                return "Other"
        }
    }

    function getBoundingColor(model)
    {
        if(model.type === UELogType.Update)
            return Colors.uGrey
        switch(model.severity)
        {
            case UESeverity.Normal:
                return Colors.uGreen
            case UESeverity.Warning:
                return Colors.uYellow
            case UESeverity.Error:
                return Colors.uRed
            case UESeverity.Inactive:
                return Colors.uLightGrey
            default:
                return Colors.uLightGreen
        }
    }
}
