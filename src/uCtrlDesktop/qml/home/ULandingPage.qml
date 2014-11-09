import QtQuick 2.0

import "../ui" as UI
import "../component"
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    property int frameMarginSize: 16
    id: container

    color: Colors.uTransparent

    width: (parent.width - frameMarginSize*2)
    height: (parent.height - frameMarginSize*2)

    anchors.left: parent.left
    anchors.leftMargin: frameMarginSize

    anchors.top: parent.top
    anchors.topMargin: frameMarginSize

    anchors.right: parent.right
    anchors.rightMargin: frameMarginSize

    anchors.bottom: parent.bottom
    anchors.bottomMargin: frameMarginSize


    Rectangle {
        id: titleArea

        width: parent.width
        height: parent.height/6

        anchors.top: parent.top
        anchors.topMargin: frameMarginSize

        anchors.left: parent.left
        anchors.leftMargin: frameMarginSize

        anchors.horizontalCenter: parent.horizontalCenter

        color: Colors.uTransparent

        ULabel.Heading1 {
            id: title
            text: "Welcome to"
            anchors.verticalCenter: parent.verticalCenter
            font.pointSize: 48
            font.bold: true
        }

        UI.UImage {
            img: "../../Images/uCtrl.svg"

            width: parent.width*0.15
            height: parent.height

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
                    main.changePageFromHome("platform/Platforms")
                    main.showBreadCrumbPlatforms()
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
                }
            }
        }
    }

}
