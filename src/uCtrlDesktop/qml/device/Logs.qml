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

            color: model.type === UELogType.Update ? Colors.uLightGrey : Colors.uTransparent
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

                    color: {
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

                    ULabel.Default
                    {
                        id: eventHeaderLabel

                        color: Colors.uWhite
                        font.pointSize: 16
                        font.bold: true

                        text: {
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
                        text: model.timestamp
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
}
