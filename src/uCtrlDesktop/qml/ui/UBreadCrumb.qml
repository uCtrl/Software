import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "UColors.js" as Colors
import "../label" as ULabel
import "../device" as Device
import "../platform"


Rectangle {

    id: breadcrumbContainer

    property variant breadcrumbModelPlatformsPath: {path: ""}
    property variant breadcrumbModelPlatformsName: {name: ""}
    property variant breadcrumbModelDevicesPath: {path: ""}
    property variant breadcrumbModelDevicesName: {name: ""}


    color: Colors.uTransparent
    width: parent.width
    height: parent.height




    Rectangle{
        id: icon
        width: 15
        height: parent.height
        color: Colors.uTransparent
        anchors.verticalCenter: breadcrumbContainer.verticalCenter
        anchors.horizontalCenter: breadcrumbContainer.horizontalCenter

        UFontAwesome {
            id: iconChevron
            iconId: "ChevronRight"
            iconColor: Colors.uWhite
            anchors.verticalCenter: icon.verticalCenter
            anchors.horizontalCenter: icon.horizontalCenter
            iconSize: 10
            visible: false
        }
    }


    Rectangle {
        id: platformsLevel
        width: 300
        height: parent.height
        color: Colors.uTransparent
        anchors.right: icon.left
        anchors.verticalCenter: parent.verticalCenter

        ULabel.Link{
            id: linkplatforms
            font.pointSize: 14
            color: Colors.uWhite
            anchors.verticalCenter: platformsLevel.verticalCenter
            anchors.right: platformsLevel.right
            text: breadcrumbModelPlatformsName
            state: "ENABLED"
            onHyperLinkClicked: {
                main.currentPage = breadcrumbModelPlatformsPath
                main.resetBreadcrumbDevices()
                main.addToBreadcrumbDevices("device/Device", "")
            }
        }
    }

    Rectangle{
        id: devicesLevel

        width: 300
        height: parent.height
        color: Colors.uTransparent
        anchors.left: icon.right
        anchors.verticalCenter: parent.verticalCenter

        ULabel.Link{
            id: linkdevice
            font.pointSize: 14
            anchors.verticalCenter: devicesLevel.verticalCenter
            anchors.left: devicesLevel.left
            color: Colors.uWhite
            state: "ENABLED"
            text: breadcrumbModelDevicesName
        }
    }






    function addToBreadcrumbPlatforms (pagePath, pageName)
    {
        breadcrumbModelPlatformsName = pageName
        breadcrumbModelPlatformsPath = pagePath
    }


    function addToBreadcrumbDevices (pagePath, pageName)
    {
        breadcrumbModelDevicesName = pageName
        breadcrumbModelDevicesPath = pagePath

        if(pageName !== ""){
            iconChevron.visible = true
        }
    }

    function resetBreadcrumbDevices(){
        breadcrumbModelDevicesName = ""
        breadcrumbModelDevicesPath = ""
        iconChevron.visible = false
    }
    function resetBreadcrumbPlatforms(){
        breadcrumbModelPlatformsName = ""
        breadcrumbModelPlatformsPath = ""
        iconChevron.visible = false
    }
    function hideBreadcrumbPlatforms(){
        iconChevron.visible = false;
        platformsLevel.visible = false
    }
    function showBreadcrumbPlatforms(){
        platformsLevel.visible = true
    }
    function showIconChevron(){
        iconChevron.visible = true
    }
}






