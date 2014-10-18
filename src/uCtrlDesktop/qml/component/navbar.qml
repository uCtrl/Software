import QtQuick 2.0

import "../ui" as UI

Rectangle {

    color: "#3C3C3C"
    width: 67;

    property variant pages: []

    Column {
        anchors.fill: parent

        Repeater {
            model: pages
            Rectangle {
                height: 50

                anchors.left: parent.left
                anchors.right: parent.right

                /*UI.UFontAwesome {
                    id: icon

                    iconId: modelData.icon
                    iconColor: "white"
                    iconSize: 24
                    anchors.centerIn: parent
                }*/

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
                    else return "#3C3C3C"
                }
            }
        }
    }
}
