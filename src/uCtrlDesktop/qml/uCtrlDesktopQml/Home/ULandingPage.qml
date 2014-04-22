import QtQuick 2.0

import "../UI" as UI
import "../UI/ULabel" as ULabel

UI.UFrame {
    contentItem: Rectangle {
        id: page

        anchors.left: parent.left
        anchors.leftMargin: frameMarginSize

        anchors.top: parent.top
        anchors.topMargin: frameMarginSize

        width: (scrollView.width - (frameMarginSize *2))
        height: (scrollView.height - (frameMarginSize *2))

        color: _colors.uTransparent

        Rectangle {
            id: content
            radius: 20

            anchors.centerIn: parent
            width: parent.width - 20
            height: parent.height - 20

            Rectangle {
                id: titleArea

                width: parent.width - 40
                anchors.right: parent.right
                height: 100
                color: _colors.uTransparent

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

                    anchors.verticalCenter: parent.verticalCenter

                    anchors.left: title.right
                    anchors.leftMargin: 10
                }
            }

            Rectangle {
                id: menuArea
                width: parent.width
                anchors.top: titleArea.bottom
                anchors.bottom: parent.bottom
                color: _colors.uTransparent

                Rectangle {
                    id: configureButtonContainer
                    width: parent.width / 3
                    height: parent.height
                    color: _colors.uTransparent

                    ULargeButton {
                        id: configureButton
                        iconId: "settings"
                        text: "Configure Platforms"

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
                    color: _colors.uTransparent

                    ULargeButton {
                        id: statisticsButton
                        iconId: "bars"
                        text: "View Usage Statistics"

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
                    color: _colors.uTransparent

                    ULargeButton {
                        id: userPreferenceButton
                        iconId: "cog2"
                        text: "Change User Settings"

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
