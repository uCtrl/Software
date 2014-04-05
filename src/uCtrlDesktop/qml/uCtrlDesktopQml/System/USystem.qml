import QtQuick 2.0
import "../UI" as UI
import "../Platform" as Platform

UI.UFrame {
    id: systemFrame

    property var system: null
    requiredModel: true

    function refresh(newSystem) {
        system = newSystem
        if (system !== null) platformListContainer.refresh(newSystem)
    }

    contentItem: Rectangle {
        id: systemContainer

        property var activePlatform: null

        property int constSize: 16
        property int separation: 10

        anchors.left: parent.left
        anchors.leftMargin: constSize

        anchors.top: parent.top
        anchors.topMargin: constSize

        width: (scrollView.width - (constSize *2))
        height: (scrollView.height - (constSize *2))

        color: _colors.uTransparent

        Rectangle {
            id: header

            property int separation: 5

            anchors.top: systemContainer.top
            anchors.left: systemContainer.left
            anchors.right: systemContainer.right

            height: 40

            color: _colors.uTransparent

            UI.UTextbox {
                id: searchBox

                anchors.left: header.left
                anchors.leftMargin: 0
                anchors.verticalCenter: header.verticalCenter

                width: platformListContainer.width - (filterCombo.width + header.separation)
                height: filterCombo.height

                state: "ENABLED"

                opacity: 0.8

                placeholderText: "Search"

                onTextChanged: {
                    platformListContainer.setFilter(searchBox.text)
                }
            }

            UI.UComboBox {
                id: filterCombo

                anchors.left: searchBox.right
                anchors.leftMargin: header.separation
                anchors.verticalCenter: header.verticalCenter

                width: 100
            }
        }

        UPlatformsList {
            id: platformListContainer

            anchors.top: header.bottom
            anchors.topMargin: 5

            anchors.left: systemContainer.left

            width: ((systemContainer.width/2) - systemContainer.separation)
            height: (systemContainer.height - header.height - 5)
        }

        Platform.UPlatform {
            id: platformInfo

            visible: (systemContainer.activePlatform !== null)

            anchors.top: platformListContainer.top
            anchors.right: systemContainer.right

            width: ((systemContainer.width/2) - systemContainer.separation)
            height: (systemContainer.height - header.height - 5)

            radius: 5

            color: _colors.uWhite
        }

        Rectangle {
            id: pleaseSelectPlatform

            visible: (systemContainer.activePlatform === null)

            anchors.top: platformListContainer.top
            anchors.right: systemContainer.right

            width: ((systemContainer.width/2) - systemContainer.separation)
            height: (systemContainer.height - header.height)

            radius: 5

            color: _colors.uTransparent

            UI.ULabel {
                id: regularText

                text: "Please select a platform"

                anchors.centerIn: pleaseSelectPlatform

                Component.onCompleted: {
                    font.pointSize = 28
                    font.bold = true
                    color = _colors.uGrey
                }
            }
        }
    }
}
