import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

import "./type" as Type

import DeviceEnums 1.0
import HistoryEnums 1.0

Rectangle {
    id: container

    property var model: null

    property var history: []
    property var logsModel: null

    property string from: ""
    property string to: ""

    property var filterType: null

    anchors.fill: parent

    Rectangle {
        id: logsHeaderContainer
        width: parent.width
        height: 50

        anchors.top: container.top
        anchors.left: container.left
        anchors.right: container.right

        color: Colors.uTransparent

        UI.UFontAwesome {
            id: logsHeaderIcon
            iconId: "info"
            iconSize: 24
            iconColor: Colors.uGrey

            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }

        ULabel.Default {
            text: "Device events"
            font.pointSize: 20
            anchors.left: logsHeaderIcon.right
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            color: Colors.uGrey
        }
    }

    Rectangle {
        id: logsContainer

        width: parent.width

        anchors.top: logsFilterContainer.bottom
        anchors.topMargin: 10
        anchors.bottom: parent.bottom

        clip: true

        ListView {
            id: historyLogs

            property variant currentItem: null

            anchors.fill: parent
            model: container.history

            delegate: Column {
                id: column

                width: parent.width
                Rectangle {
                    width: parent.width
                    height: 50

                    color: getBackgroundColor(model)
                    anchors.leftMargin: -5
                    anchors.rightMargin: -5
                    radius: 5

                    visible: (container.filterType === "Any" || container.filterType === model.type.toString())

                    Rectangle {
                        id: content
                        width: parent.width - 20
                        height: parent.height - 4
                        anchors.centerIn: parent
                        color: Colors.uTransparent

                        Rectangle {
                            id: eventHeader

                            width: 140
                            height: parent.height - 10
                            anchors.verticalCenter: parent.verticalCenter
                            radius: 5

                            color: getBoundingColor(model)

                            ULabel.Default {
                                id: eventHeaderLabel

                                color: Colors.uWhite
                                font.pointSize: 16
                                font.bold: true

                                text: getHeaderText(model)

                                anchors.centerIn: parent
                            }
                        }

                        Rectangle {
                            id: eventDescription

                            anchors.left: eventHeader.right
                            anchors.leftMargin: 10
                            anchors.right: eventTimestamp.left
                            height: parent.height
                            color: Colors.uTransparent

                            Rectangle {
                                id: eventDescriptionIcon
                                visible: model.type === UELogType.Update

                                width: model.type === UELogType.Update ? parent.height : 0
                                height: parent.height
                                color: Colors.uTransparent

                                UI.UFontAwesome {
                                    iconColor: Colors.uGrey
                                    iconId: "earth"
                                    iconSize: 18
                                    anchors.centerIn: parent
                                }
                            }

                            Rectangle {
                                anchors.left: eventDescriptionIcon.right
                                anchors.right: parent.right
                                height: parent.height
                                color: Colors.uTransparent

                                ULabel.Default {
                                    text: model.message
                                    width: parent.width
                                    anchors.verticalCenter: parent.verticalCenter
                                    color: Colors.uGrey
                                }
                            }
                        }

                        Rectangle {
                            id: eventTimestamp
                            width: parent.width * 0.25
                            height: parent.height
                            anchors.right: parent.right
                            color: Colors.uTransparent

                            ULabel.Default {
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
        }
    }

    Rectangle {
        id: logsFilterContainer
        width: parent.width
        height: 40
        anchors.top: logsHeaderContainer.bottom

        UI.UCombobox {
            id: filterType
            width: 150
            height: parent.height
            itemListModel: [
                { value:"Any", displayedValue:"Any event", iconId:""},
                { value:"0", displayedValue:"Action", iconId:""},
                { value:"1", displayedValue:"Condition", iconId:""},
                { value:"2", displayedValue:"Scenario", iconId:""},
                { value:"3", displayedValue:"Status", iconId:""},
                { value:"4", displayedValue:"Update", iconId:""},
            ]
            Component.onCompleted: selectItem(0)
            onSelectValue: container.filterType = newValue
        }

        UI.UCombobox {
            id: filterDate
            anchors.left: filterType.right
            anchors.leftMargin: 10
            anchors.right: parent.right
            height: parent.height
            itemListModel: [
                { value:"hour", displayedValue:"This hour", iconId:""},
                { value:"today", displayedValue:"Today", iconId:""},
                { value:"month", displayedValue:"This month", iconId:""},
                { value:"Yeah", displayedValue:"This year", iconId:""},
            ]
            Component.onCompleted: selectItem(0)
            onSelectValue: updateLogPeriod()
        }
    }

    onModelChanged: {
        container.logsModel = devicesList.getHistoryWithId(model.id);
        container.logsModel.logsReceived.disconnect(updateHistory);
        container.logsModel.logsReceived.connect(updateHistory);
    }


    function getTimestampLabel(timestamp) {
        var nowDate = new Date()
        var timestampDate = new Date(timestamp);
        var nowTimestamp = nowDate.getTime()

        var deltaTime = Math.abs(nowTimestamp - timestamp)

        var minute = 60
        var hour = 60 * minute
        var day = 24 * hour
        var week = 7 * day

        if (deltaTime < minute) {
            return "Less than a minute ago"
        }

        else if (nowDate.getDate() === timestampDate.getDate()) {
            return "Today at " + Qt.formatDateTime(timestampDate, "HH:mm:ss")
        }

        else if(nowDate.getDate() - 1 === timestampDate.getDate()) {
            return "Yesterday at " + Qt.formatDateTime(timestampDate, "HH:mm:ss")
        }

        else {
            return Qt.formatDateTime(timestampDate, "dd-MM-yyyy HH:mm")
        }
    }

    function getBackgroundColor(model) {
        return model.type === UELogType.Update ? Colors.uLightGrey : Colors.uTransparent
    }

    function getHeaderText(model) {
        switch(model.type) {
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

    function getBoundingColor(model) {
        if(model.type === UELogType.Update) return Colors.uGrey

        switch(model.severity) {
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

    function updateLogPeriod() {
        if (filterDate.selectedItem !== null) var period = filterDate.selectedItem.value
        else period = "hour"

        var interval = ""

        console.log(period)
        switch (period) {
        case "hour":
            container.from = new Date().setMinutes(0, 0).toString()
            break;
        case "today":
            container.from = new Date().setHours(0, 0, 0).toString()
            break;
        case "month":
            container.from = new Date().setDate(1, 0, 0, 0).toString()
            break;
        case "year":
            container.from = new Date().setMonth(0, 1, 0, 0, 0).toString()
            break;
        }

        container.to = new Date().getTime().toString()
        uCtrlApiFacade.getDeviceHistory(devicesList.findObject(model.id), {"from": container.from, "to": container.to, "type": container.type, "fn": "mean"});
    }

    function updateHistory() {
        container.history = devicesList.getHistoryWithId(model.id);
        container.logsModel = container.history
        historyLogs.model = container.logsModel
    }
}
