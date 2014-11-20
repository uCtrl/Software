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

    Rectangle {
        id: container

        color: Colors.uTransparent
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        height: parent.height
        width: 500

        Rectangle{
            id: platformsLevel

            height: container.height / 2
            width: 300
            anchors.right: parent.right
            color: Colors.uTransparent

            ULabel.Link{
                font.pointSize: 15
                color: Colors.uWhite
                anchors.top: platformsLevel.top
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

            height: container.height / 2
            width: 300
            anchors.top: platformsLevel.bottom
            anchors.right: parent.right
            color: Colors.uTransparent

            ULabel.Link{
                id: linkdevice
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: devicesLevel.right
                anchors.leftMargin: 25
                color: Colors.uWhite
                text: breadCrumbModeldevices[0].name
            }
            UFontAwesome {
                id: iconForward

                iconId: "forward"
                iconColor: Colors.uWhite
                iconSize: 20
                anchors.right: linkdevice.left
                anchors.rightMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }
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
            iconForward.visible = true
        }

    }
    function resetBreadcrumbDevices(){
        breadCrumbModeldevices = []
        iconForward.visible = false
    }
    function resetBreadcrumbPlatforms(){
        breadcrumbModelPlatforms = []
        iconForward.visible = false
    }
    function hideBreadcrumbPlatforms(){
        iconForward.visible = false;
        platformsLevel.visible = false
    }
    function showBreadcrumbPlatforms(){
        platformsLevel.visible = true
    }
    function showIconForward(){
        iconForward.visible = true
    }
}






