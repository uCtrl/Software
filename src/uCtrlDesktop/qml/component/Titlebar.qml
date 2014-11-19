import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors


Rectangle {
    id: titlebar

    color: Colors.uGreen
    height: 65

    property var pages: null

    UI.UImage {
        id: logo

        width: 80
        height: 45

        anchors.verticalCenter: parent.verticalCenter

        anchors.left: parent.left
        anchors.leftMargin: 12

        img: "../img/uCtrl-white.svg"
    }

    UI.UBreadCrumb{
        id: breadcrumb

        width: 400
        height: 50
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 12
    }

    function addToBreadcrumbDevices(path, pageName){
        breadcrumb.addToBreadcrumbDevices(path, pageName)
    }
    function addToBreadcrumbPlatforms(path, pageName){
        breadcrumb.addToBreadcrumbPlatforms(path, pageName)
    }

    function resetBreadcrumbDevices(){
        breadcrumb.resetBreadcrumbDevices()
    }
    function resetBreadcrumbPlatforms(){
        breadcrumb.resetBreadcrumbPlatforms()
    }
    function hideBreadcrumbPlatforms(){
        breadcrumb.hideBreadcrumbPlatforms()
    }
    function showBreadcrumbPlatforms(){
        breadcrumb.showBreadcrumbPlatforms()
    }
}
