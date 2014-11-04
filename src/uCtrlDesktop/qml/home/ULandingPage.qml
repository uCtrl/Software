import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

UI.UFrame {
    contentItem: Rectangle {
        id: page

        anchors.left: parent.left
        anchors.leftMargin: frameMarginSize

        anchors.top: parent.top
        anchors.topMargin: frameMarginSize

        width: (scrollView.width - (frameMarginSize *2))
        height: (scrollView.height - (frameMarginSize *2))

        color: Colors.uTransparent

        Rectangle {
            id: content
            radius: radiusSize

            anchors.centerIn: parent
            width: parent.width
            height: parent.height

            Rectangle {
                id: titleArea

                width: parent.width + (frameMarginSize * 2)
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.topMargin: 5
                anchors.leftMargin: frameMarginSize

                height: 100
                color: Colors.uTransparent

                ULabel.Heading1 {
                    id: title
                    text: "Welcome to"
                    anchors.verticalCenter: parent.verticalCenter
                    font.pointSize: 32
                    font.bold: true
                }

                UI.UImage {
                    img: "qrc:///Resources/Images/uCtrl.svg"

                    width: 150
                    height: 150
                    smooth: false

                    anchors.verticalCenter: parent.verticalCenter

                    anchors.left: title.right
                    anchors.leftMargin: 10
                }
            }

            Rectangle {
                id: menuArea
                width: parent.width * 0.90
                height: parent.height * 0.60
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: (titleArea.height / 2)
                color: Colors.uTransparent

                Rectangle {
                    id: configureButtonContainer
                    width: parent.width / 3
                    height: parent.height
                    color: Colors.uTransparent

                    ULargeButton {
                        id: configureButton
                        iconId: "settings"
                        text: "Configure Platforms"
                        width: parent.width * 0.85
                        height: parent.height

                        onClicked: {
                            main.resetBreadcrumb()
                            main.highlightNavbar("Configuration")
                            main.swap(_paths.uSystem, _paths.uSystemTitle, mySystem)
                        }
                    }
                }
                Rectangle {
                    id: statisticsButtonContainer
                    anchors.left: configureButtonContainer.right
                    width: parent.width / 3
                    height: parent.height
                    color: Colors.uTransparent

                    ULargeButton {
                        id: statisticsButton
                        iconId: "bars"
                        text: "View Usage Statistics"
                        width: parent.width * 0.85
                        height: parent.height

                        onClicked: {
                            main.resetBreadcrumb()
                            main.highlightNavbar("Statistics")
                            main.swap(_paths.uStatistics, _paths.uStatisticsTitle, "")
                        }
                    }
                }
                Rectangle {
                    id: userPreferenceButtonContainer
                    anchors.right: parent.right
                    width: parent.width / 3
                    height: parent.height
                    color: Colors.uTransparent

                    ULargeButton {
                        id: userPreferenceButton
                        iconId: "cog2"
                        text: "Change User Settings"
                        width: parent.width * 0.85
                        height: parent.height

                        onClicked: {
                            main.resetBreadcrumb()
                            main.highlightNavbar("Settings")
                            main.swap(_paths.uHome, _paths.uHomeTitle, "")
                        }
                    }
                }
            }
        }
    }
}
