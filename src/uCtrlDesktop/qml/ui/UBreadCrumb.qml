import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "UColors.js" as Colors
import "../label" as ULabel
import "../device" as Device
import "../platform"



Rectangle {

    id: breadcrumbContainer

    property variant breadcrumbModelPlatforms: []
    property variant breadCrumbModeldevices: []







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
            font.pointSize: 16
            color: Colors.uWhite
            anchors.verticalCenter: platformsLevel.verticalCenter
            anchors.right: platformsLevel.right
            text: breadcrumbModelPlatforms[0].name

            onHyperLinkClicked: {
                main.currentPage = breadcrumbModelPlatforms[0].path
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
            font.pointSize: 16
            anchors.verticalCenter: devicesLevel.verticalCenter
            anchors.left: devicesLevel.left
            color: Colors.uWhite
            text: breadCrumbModeldevices[0].name
        }
    }




    function addToBreadcrumbPlatforms (pagePath, pageName)
    {

        var newModel = []
        for(var i = 0; i < breadcrumbModelPlatforms.length; i++) {
            newModel.push(breadcrumbModelPlatforms[i])
        }

        var newItem = {path: pagePath, name: pageName}
        newModel.push(newItem)

        breadcrumbModelPlatforms = newModel
    }
    function addToBreadcrumbDevices (pagePath, pageName)
    {

        var newModel = []
        for(var i = 0; i < breadCrumbModeldevices.length; i++) {
            newModel.push(breadCrumbModeldevices[i])
        }

        var newItem = {path: pagePath, name: pageName}
        newModel.push(newItem)

        breadCrumbModeldevices = newModel
        if(pageName !== ""){
            iconChevron.visible = true
        }

    }
    function resetBreadcrumbDevices(){
        breadCrumbModeldevices = []
        iconChevron.visible = false
    }
    function resetBreadcrumbPlatforms(){
        breadcrumbModelPlatforms = []
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






