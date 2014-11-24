import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors

Rectangle {

    id: navbar

    color: Colors.uDarkGrey
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
                    iconColor: Colors.uWhite
                    iconSize: 24
                    anchors.centerIn: parent
                }

                visible: modelData.showInNavBar

                color: getBackgroundColor()

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: {


                        main.currentPage = modelData.file;


                        if(currentPage !== "platform/Platforms"){
                            main.hideBreadcrumbPlatforms()
                            main.resetBreadcrumbDevices()
                            main.addToBreadcrumbDevices("device/Device", "")
                        }
                        if(currentPage === "platform/Platforms"){
                            main.resetBreadcrumbDevices()
                            main.showBreadcrumbPlatforms()
                            main.addToBreadcrumbDevices("device/Device", "")
                        }
                    }
                }

                function getBackgroundColor() {
                    if (mouseArea.containsMouse) return Colors.uDarkGreyHover
                    else if (main.currentPage === modelData.file) return Colors.uDarkestGrey
                    else return navbar.color
                }
            }
        }
    }
}
