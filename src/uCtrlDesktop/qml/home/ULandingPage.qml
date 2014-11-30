import QtQuick 2.0

import "../ui" as UI
import "../component"
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    property int marginSize: 16
    id: container

    color: Colors.uTransparent

    width: (parent.width - marginSize*2)
    height: (parent.height - marginSize*2)

    anchors.left: parent.left
    anchors.leftMargin: marginSize

    anchors.top: parent.top
    anchors.topMargin: marginSize

    anchors.right: parent.right
    anchors.rightMargin: marginSize

    anchors.bottom: parent.bottom
    anchors.bottomMargin: marginSize


    Rectangle {
        id: titleArea

        width: parent.width
        height: parent.height/6

        anchors.top: parent.top
        anchors.topMargin: marginSize

        anchors.left: parent.left
        anchors.leftMargin: marginSize

        anchors.horizontalCenter: parent.horizontalCenter

        color: Colors.uTransparent
        ULabel.Default {
            id: title
            text: "Welcome to"

            anchors.verticalCenter: parent.verticalCenter
            font.bold: true
            font.pointSize: 48
            color: Colors.uGreen
        }

        UI.UImage {
            img: "../../Images/uCtrl-Icon.png"

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
                    var page = main.searchPages("platform/Platforms")

                    main.currentPage = page.file
                    main.addToBreadcrumb(page.file, page.text, 1)
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
                    var page = main.searchPages("settings/Settings")

                    main.currentPage = page.file
                    main.addToBreadcrumb(page.file, page.text, 1)
                }
            }
        }
    }

}
