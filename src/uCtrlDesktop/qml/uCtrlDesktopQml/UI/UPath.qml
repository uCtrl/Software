import QtQuick 2.0

QtObject {
    property string root: "."

    property string uConfig: root + "/DeviceConfiguration/UDeviceConfiguration.qml"
    property string uConfigTitle: "Configuration"

    property string uHome: root + "/Home/UHome.qml"
    property string uHomeTitle: "uCtrl"

    property string uStatistics: root + "/Statistics/UStatistics.qml"
    property string uStatisticsTitle: "Statistics"

    property string uSystem: root + "/System/USystem.qml"
    property string uSystemTitle: "Platform"
}
