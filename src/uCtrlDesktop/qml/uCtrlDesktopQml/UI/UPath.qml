import QtQuick 2.0

QtObject {
    property string root: "."

    property string uConfig: root + "/DeviceConfiguration/UDeviceConfiguration.qml"
    property string uConfigTitle: "Configuration"

    property string uLandingPage: root + "/Home/ULandingPage.qml"
    property string uLandingPageTitle: "uCtrl"

    property string uHome: root + "/Home/UHome.qml"
    property string uHomeTitle: "Dashboard"

    property string uStatistics: root + "/Statistics/UStatistics.qml"
    property string uStatisticsTitle: "Statistics"

    property string uSystem: root + "/System/USystem.qml"
    property string uSystemTitle: "Platform"
}
