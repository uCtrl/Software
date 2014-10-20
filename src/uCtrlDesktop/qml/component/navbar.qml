import QtQuick 2.0

import "../ui" as UI

Rectangle {

    id: navbar

    color: "#3C3C3C"
    width: 67;

    property variant pages: []

    Column {
        id: column

        anchors.fill: parent

        Repeater {
            id: repeater

            model: pages
            Rectangle {
                id: rectangle

                height: 50

                anchors.left: parent.left
                anchors.right: parent.right

                UI.UFontAwesome {
                    id: icon

                    iconId: modelData.icon
                    iconColor: "white"
                    iconSize: 24
                    anchors.centerIn: parent
                }

                visible: modelData.showInNavbar

                color: getBackgroundColor()

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {
                        main.currentPage = modelData.file;
                    }
                }

                function getBackgroundColor() {
                    if (mouseArea.containsMouse) return "#5A5A5A"
                    else if (main.currentPage === modelData.file) return "#222222"
                    else return navbar.color
                }
            }
        }
    }
}
