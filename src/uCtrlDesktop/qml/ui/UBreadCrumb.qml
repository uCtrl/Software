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

    property var pages: null

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

            height: parent.height
            width: 250

            anchors.left: parent.left
            color: Colors.uTransparent

            ULabel.Link{
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
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

            height: parent.height
            width: 200
            anchors.left: element1.right

            color: Colors.uTransparent

            ULabel.Link{
                font.pointSize: 15
                anchors.verticalCenter: parent.verticalCenter
                text: breadCrumbModeldevices[0].name
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
    }


    function resetBreadCrumbdevices(){
        console.log("yo")
        breadCrumbModeldevices = []
    }
    function resetBreadCrumbplatforms(){
        breadCrumbModelplatforms = []
    }
    function hideBreadCrumbPlatforms(){
        element1.visible = false
    }
    function showBreadCrumbPlatforms(){
        element1.visible = true
    }
}







    /*ListView {
        id: historyLogs

        anchors.left: parent.left
        anchors.horizontalCenter: parent.horizontalCenter
        orientation: ListView.Horizontal
        model: breadcrumbContainer.breadCrumbModel

        delegate: Row{
            ULabel.Link{

                text: index !== 0? " / " + breadCrumbModel[index].name : breadCrumbModel[index].name

                onHyperLinkClicked: {

                    if (index == 0){
                        main.currentPage = breadCrumbModel[index].path
                        main.resetBreadCrumb()
                    }

                    if (index == 1){
                        main.currentPage = breadCrumbModel[index].path
                    }
                }
            }
        }
    }

    function addToBreadCrumb (pagePath, pageName)
    {
        var newModel = []
        for(var i = 0; i < breadCrumbModel.length; i++) {
            newModel.push(breadCrumbModel[i])

        }

        var newItem = {path: pagePath, name: pageName}
        newModel.push(newItem)

        breadCrumbModel = newModel

        console.log(platformsList)

    }

    function resetBreadCrumb(){
        breadCrumbModel = []
    }*/
