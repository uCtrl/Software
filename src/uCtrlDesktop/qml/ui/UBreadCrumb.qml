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
        id: devicesLevel
        width: 500
        height: breadcrumbContainer.height
        color: Colors.uTransparent
        anchors.right: breadcrumbContainer.right
        anchors.verticalCenter: breadcrumbContainer.verticalCenter


        ULabel.Link{
            id: linkplatforms
            font.pointSize: 14
            color: Colors.uWhite
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            text: breadcrumbModelPlatformsName
            state: "ENABLED"
            onHyperLinkClicked: {
                main.currentPage = breadcrumbModelPlatformsPath
                main.resetBreadcrumbDevices()
            }
        }

        ULabel.Link{
            id: linkdevice
            font.pointSize: 14
            anchors.verticalCenter: devicesLevel.verticalCenter
            anchors.right: devicesLevel.right
            color: Colors.uWhite
            state: "ENABLED"
            text: breadcrumbModelDevicesName
        }

        UFontAwesome {
            id: iconChevron
            iconId: "ChevronRight"
            iconSize: 10
            iconColor: Colors.uWhite
            anchors.rightMargin: 10
            anchors.right: linkdevice.left
            anchors.verticalCenter: devicesLevel.verticalCenter
            visible: false
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
        iconChevron.visible = true
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
        iconChevron.visible = false
        linkplatforms.visible = false
    }

    function showBreadcrumbPlatforms(){
        linkplatforms.visible = true
    }

    function moveBreadcrumbPlatforms(){
        linkplatforms.anchors.right = iconChevron.left
    }

    function showIconChevron(){
        iconChevron.visible = true
    }
}






