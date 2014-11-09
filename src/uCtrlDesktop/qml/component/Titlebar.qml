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
        height: 45

        anchors.verticalCenter: parent.verticalCenter

        anchors.right: parent.right
        anchors.rightMargin: 12

        pages: titlebar.pages
    }

    function addToBreadCrumbdevices(path, pageName){
        breadcrumb.addToBreadCrumbdevices(path, pageName)
    }
    function addToBreadCrumbplatforms(path, pageName){
        breadcrumb.addToBreadCrumbplatforms(path, pageName)
    }

    function resetBreadCrumbdevices(){
        breadcrumb.resetBreadCrumbdevices()
    }
    function resetBreadCrumbplatforms(){
        breadcrumb.resetBreadCrumbplatforms()
    }
    function hideBreadCrumbPlatforms(){
        breadcrumb.hideBreadCrumbPlatforms()
    }
    function showBreadCrumbPlatforms(){
        breadcrumb.showBreadCrumbPlatforms()
    }
}
