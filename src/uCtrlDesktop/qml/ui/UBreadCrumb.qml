import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "UColors.js" as Colors
import "../label" as ULabel
import "../device" as Device
import "../platform"


Rectangle {

    id: breadcrumbContainer

    property variant breadcrumbModel: []

    color: Colors.uTransparent
    width: 600
    height: parent.height

    Rectangle{
        id: platforms

        color: Colors.uTransparent
        height: breadcrumbContainer.height
        anchors.right: breadcrumbContainer.right
        anchors.verticalCenter: breadcrumbContainer.verticalCenter

        ListView
        {
            orientation: ListView.Horizontal
            model: breadcrumbModel

            delegate: Rectangle
            {
                width: link.width + iconChevron.width + 20
                height: platforms.height
                ULabel.Link
                {
                    id: link
                    font.pointSize: 14
                    color: Colors.uWhite

                    text: model.name

                    onHyperLinkClicked: {
                        main.currentPage = model.path
                        resetBreadcrumb(index)
                    }
                }

                UFontAwesome {
                    id: iconChevron
                    iconId: "ChevronRight"
                    iconSize: 10
                    iconColor: Colors.uWhite

                    anchors.left: link.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    visible: breadcrumbModelDevicesName !== ""
                }
            }
        }
    }

    function addToBreadcrumb(pagePath, pageName, level)
    {
        resetBreadCrumb(level)
        breadcrumbModel[level] = { path: pagePath, name: pageName }
    }

    function resetBreadCrumb(level)
    {
         var newBreadCrumbModel = []

        for(var i = 0; i <= level || i; i++)
        {
            newBreadCrumbModel[i] = { path: breadcrumbModel[i].path, name: breadcrumbModel[i].name }
        }
        breadcrumbModel = newBreadCrumbModel
    }
}






