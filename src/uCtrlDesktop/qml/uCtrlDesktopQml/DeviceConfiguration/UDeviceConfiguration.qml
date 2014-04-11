import QtQuick 2.0
import "../UI" as UI
import "../DeviceInformation" as Info

UI.UFrame {
    id: deviceConfig

    requiredModel: true

    property var device

    function refresh(newDevice) {
        device = newDevice
        deviceTab.refresh(device)
        info.refresh(device)
    }

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
            id: backButtonContainer
            width: parent.width
            height: 50

            color: _colors.uTransparent

            UI.UButton {
                text: "< Back to Platform"
                width: 150
                anchors.verticalCenter: parent.verticalCenter

                onClicked: {
                    main.swap(_paths.uSystem, _paths.uSystemTitle, mySystem)
                }
            }
        }
        Rectangle {
            id: contentContainer
            width: parent.width
            color: _colors.uWhite
            anchors.top: backButtonContainer.bottom
            anchors.bottom: parent.bottom

            radius: 10

            Rectangle {
                id: contentMargin
                width: parent.width - 20
                height: parent.height - 20
                anchors.centerIn: parent
                color: _colors.uTransparent

                Rectangle {
                    id: leftWindow
                    width: parent.width * 0.5 - 10
                    height: parent.height
                    color: _colors.uTransparent

                    Rectangle {
                        id: infoWindow

                        anchors.fill: parent

                        color: _colors.uTransparent

                        Info.UInfo {
                            id: info

                            anchors.fill: parent
                        }
                    }
                }

                Rectangle {
                    color: _colors.uLightGrey
                    height: parent.height
                    width: 2
                    anchors.right: rightWindow.left
                }

                Rectangle {
                    id: rightWindow
                    width: parent.width * 0.5
                    height: parent.height
                    anchors.right: parent.right
                    color: _colors.uTransparent

                    Rectangle {
                        id: tabsContainer
                        width: parent.width
                        height: 50
                        color: _colors.uTransparent
                        anchors.top: parent.top
                        anchors.topMargin: 20

                        UI.UTabs {
                            width: 300
                            height: 40
                            anchors.centerIn: parent

                            icons: ["Off",    "Time",    "BarChart"]
                            texts: ["",       "",        ""]
                            ids:   ["Config", "History", "Statistics"]
                        }
                    }

                    Rectangle {
                        id: content
                        width: parent.width

                        anchors.top: tabsContainer.bottom
                        anchors.topMargin: 20

                        anchors.left: parent.left
                        anchors.leftMargin: 10

                        anchors.right: parent.right
                        anchors.bottom: parent.bottom

                        color: _colors.uTransparent

                        UDeviceConfigTab {
                            id: deviceTab
                        }
                    }
                }
            }
        }
    }
}
