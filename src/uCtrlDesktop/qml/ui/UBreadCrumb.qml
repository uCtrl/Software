import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "UColors.js" as Colors
import "../label" as ULabel


Rectangle {

    id: breadcrumbContainer

    property variant breadCrumbModel: []
    //color: Colors.uTransparent
    width: parent.width
    height: parent.height
    color: "red"


    ListView {
        id: historyLogs

        anchors.fill: parent

        model: breadcrumbContainer.breadCrumbModel

        delegate: Row{
            ULabel.Link{
                text: breadCrumbModel[index].name
            }
        }
    }

    function changePage (pagePath, pageName)
    {
        var newModel = []
        for(var i = 0; i < breadCrumbModel.length; i++) {
            newModel.push(breadCrumbModel[i])
        }

        var newItem = {path: pagePath, name: pageName}
        newModel.push(newItem)

        breadCrumbModel = newModel
    }
}

