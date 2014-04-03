import QtQuick 2.0

import "../UI/ULabel" as ULabel

Item {
    property var links: ["Level 1", "Level 2", "Level 3"]
    property int listSpacing: 15
    anchors.fill: parent

    Component {
        id: breadcrumbElement
        Rectangle {
            height: parent.height
            color: _colors.uTransparent
            width: breadcrumbLabel.width + chevron.width + listSpacing * 2;
            ULabel.Heading4 {
                id: breadcrumbLabel
                text: links[links.length - index - 1]
                anchors.verticalCenter: parent.verticalCenter
                color: _colors.uWhite
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
        anchors.rightMargin: 10
        delegate: breadcrumbElement
        orientation: ListView.Horizontal
        rotation: 180
    }

}
