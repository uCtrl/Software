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
    width: 600
    height: parent.height


    Rectangle{
        id: platforms

        color: Colors.uTransparent
        height: breadcrumbContainer.height
        anchors.right: breadcrumbContainer.right
        anchors.verticalCenter: breadcrumbContainer.verticalCenter

        ULabel.Link{
            id: platformsLink
            font.pointSize: 14
            color: Colors.uWhite
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: if(breadcrumbModelDevicesName !== "") iconChevron.left;else parent.right
            anchors.rightMargin: if(breadcrumbModelDevicesName !== "") 10;else 0
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
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
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
            anchors.leftMargin: 10
            anchors.right: linkdevice.left
            anchors.verticalCenter: parent.verticalCenter
            visible: if(breadcrumbModelDevicesName !== "") true;else false
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

    }

    function resetBreadcrumbDevices(){
        breadcrumbModelDevicesName = ""
        breadcrumbModelDevicesPath = ""

    }

    function resetBreadcrumbPlatforms(){
        breadcrumbModelPlatformsName = ""
        breadcrumbModelPlatformsPath = ""

    }

    function hideBreadcrumbPlatforms(){
        platformsLink.visible = false
    }

    function showBreadcrumbPlatforms(){
        platformsLink.visible = true
    }
}






