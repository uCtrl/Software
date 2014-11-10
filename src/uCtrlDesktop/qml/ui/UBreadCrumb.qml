import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "UColors.js" as Colors
import "../label" as ULabel
import "../device" as Device
import "../platform"

Rectangle {

    id: breadcrumbContainer

    property variant breadCrumbModelplatforms: []
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
            id: element1

            height: container.height / 2
            width: 300
            anchors.left: parent.left
            color: Colors.uTransparent

            ULabel.Link{
                font.pointSize: 15
                anchors.top: element1.top

                text: breadCrumbModelplatforms[0].name
                onHyperLinkClicked: {
                    main.currentPage = breadCrumbModelplatforms[0].path
                    main.resetBreadCrumbdevices()
                    main.addToBreadCrumbdevices("device/Device", "")
                }
            }
        }

        Rectangle{
            id: element2

            height: container.height / 2
            width: 300
            anchors.top: element1.bottom
            color: Colors.uTransparent

            ULabel.Link{
                id: linkdevice
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: iconForward.right
                anchors.leftMargin: 25
                text: breadCrumbModeldevices[0].name
            }
            UFontAwesome {
                id: iconForward

                iconId: "forward"
                iconColor: Colors.uWhite
                iconSize: 20
                anchors.left: element2.left
                anchors.leftMargin: 25
                anchors.verticalCenter: parent.verticalCenter
                visible: false
            }
        }

    }


    function addToBreadCrumbplatforms (pagePath, pageName)
    {

        var newModel = []
        for(var i = 0; i < breadCrumbModelplatforms.length; i++) {
            newModel.push(breadCrumbModelplatforms[i])
        }

        var newItem = {path: pagePath, name: pageName}
        newModel.push(newItem)

        breadCrumbModelplatforms = newModel
    }
    function addToBreadCrumbdevices (pagePath, pageName)
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
    function resetBreadCrumbdevices(){
        breadCrumbModeldevices = []
        iconForward.visible = false
    }
    function resetBreadCrumbplatforms(){
        breadCrumbModelplatforms = []
        iconForward.visible = false
    }
    function hideBreadCrumbPlatforms(){
        iconForward.visible = false;
        element1.visible = false
    }
    function showBreadCrumbPlatforms(){
        element1.visible = true
    }
    function showIconForward(){
        iconForward.visible = true
    }
}






