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
    width: 600
    height: parent.height

    color: Colors.uTransparent

    Rectangle
    {
        width: breadcrumbListView.width
        height: parent.height

        anchors.right: parent.right

        color: Colors.uTransparent
        ListView
        {
            id: breadcrumbListView
            orientation: ListView.Horizontal
            model: breadcrumbContainer.breadcrumbModel
            height: parent.height
            width: 0

            interactive: false

            anchors.right: parent.right

            delegate: Rectangle
            {
                width: link.width + iconChevron.width + (iconChevron.visible ? 20 : 0)
                height: parent.height

                color: Colors.uTransparent

                Component.onCompleted: {
                    breadcrumbListView.width += width
                }

                ULabel.Link
                {
                    id: link
                    font.pointSize: 14
                    color: Colors.uWhite

                    anchors.verticalCenter: parent.verticalCenter

                    text: breadcrumbModel[index].name

                    onHyperLinkClicked: {
                        if(index !== breadcrumbModel.length - 1)
                        {
                            main.currentPage = breadcrumbModel[index].path
                            main.addToBreadcrumb(breadcrumbModel[index].path, breadcrumbModel[index].name, index)
                        }
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
                    visible: index !== breadcrumbContainer.breadcrumbModel.length - 1
                }
            }
        }
    }
    function addToBreadcrumb(pagePath, pageName, level)
    {
        if(breadcrumbModel.length > 0 && breadcrumbModel[breadcrumbModel.length-1].path === pagePath &&
                                         breadcrumbModel[breadcrumbModel.length-1].name === pageName &&
                                         breadcrumbModel.length-1 === level)
            return

        breadcrumbListView.width = 0

        var newModel = []

        for(var i = 0; i <= level && i < breadcrumbContainer.breadcrumbModel.length; i++)
        {
            newModel[i] = { path: breadcrumbContainer.breadcrumbModel[i].path, name: breadcrumbContainer.breadcrumbModel[i].name }
        }

        newModel[level] =  { path: pagePath, name: pageName }
        breadcrumbContainer.breadcrumbModel = newModel
    }
}






