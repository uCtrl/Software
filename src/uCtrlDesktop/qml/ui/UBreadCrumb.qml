import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "UColors.js" as Colors
import "../label" as ULabel


Rectangle {

    id: breadcrumbContainer

    property variant breadCrumbModel_Path: []
    property variant breadCrumbModel_Name: []
    color: Colors.uTransparent
    width: parent.width
    height: parent.height


    ListView {
        id: historyLogs

        anchors.fill: parent

        model: breadcrumbContainer.breadCrumbModel_Name


        delegate: Row{
            ULabel.Link{
                text: breadCrumbModel_Name[index]
            }

        }
    }

    function changePage (pagePath, pageName){

        breadCrumbModel_Path.push(pagePath)
        breadCrumbModel_Name.push(pageName)
        console.log(breadCrumbModel_Path)
        console.log(breadCrumbModel_Name)
        console.log(pagePath)
        console.log(pageName)

    }
}

