import QtQuick 2.0

import "../UI/ULabel" as ULabel

Item {
    id: breadcrumb

    property var links: []
    property var redirectPath: []
    property var redirectModel: []
    property int listSpacing: 15

    function resetBreadcrumb() {
        redirectPath = []
        redirectModel = []
        links = []
    }

    function changeBreadcrumb(path, title, model) {
        var newLinks = []
        var newPath = []
        var newModel = []
        var append = true;
        for(var i = 0; i < links.length; i++) {
            if(redirectPath[i] !== path)
            {
                newLinks.push(links[i])
                newPath.push(redirectPath[i])
                newModel.push(redirectModel[i])
            }
            else {
                newLinks.push(title)
                newPath.push(path)
                newModel.push(model)
                append = false;
                break;
            }
        }
        if(append)
        {
            newLinks.push(title)
            newPath.push(path)
            newModel.push(model)
        }

        links = newLinks
        redirectPath = newPath
        redirectModel = newModel
    }


    anchors.fill: parent

    Component {
        id: breadcrumbElement
        Rectangle {
            height: parent.height
            color: _colors.uTransparent
            width: breadcrumbLabel.width + chevron.width + listSpacing * 2;
            ULabel.Link {
                id: breadcrumbLabel
                text: breadcrumb.links[breadcrumb.links.length - index - 1]
                redirectModel: breadcrumb.redirectModel[breadcrumb.links.length - index - 1]
                redirectPath: breadcrumb.redirectPath[breadcrumb.links.length - index - 1]
                anchors.verticalCenter: parent.verticalCenter
                color: _colors.uWhite
                font.pointSize: 16
                rotation: 180
            }
            Loader {
                id: chevron
                sourceComponent: (index === links.length - 1 ? emptyElement : chevronElement)
                anchors.left: breadcrumbLabel.right
                anchors.leftMargin: listSpacing
                anchors.verticalCenter: parent.verticalCenter
                rotation: 180
            }
            Component {
                id: emptyElement
                ULabel.Default {

                }
            }
            Component {
                id: chevronElement
                UFontAwesome {
                    iconId: "ChevronRight"
                    iconSize: 10
                    iconColor: _colors.uWhite
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
    ListView {
        id: list
        model: links
        anchors.fill: parent
        anchors.right: parent.right
        anchors.rightMargin: 23
        delegate: breadcrumbElement
        orientation: ListView.Horizontal
        rotation: 180
    }

}
