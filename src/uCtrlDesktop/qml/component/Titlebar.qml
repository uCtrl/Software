import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors


Rectangle {
    id: titlebar

    color: Colors.uGreen
    height: resourceLoader.loadResource("titlebarheight")

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
        height: resourceLoader.loadResource("titlebarBreadcrumbheight")
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: resourceLoader.loadResource("titlebarBreadcrumbRightmargin")

    }

    function initBreadcrumb (){
        breadcrumb.initBreadcrumb()
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
    function moveBreadcrumbPlatforms(){
        breadcrumb.moveBreadcrumbPlatforms()
    }
}
