import QtQuick 2.0
import "../UI" as UI
import "../Scenario" as Scenario

UI.UFrame {
    id: deviceConfig

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
                    id: descriptionContainer
                    width: parent.width * 0.5
                    height: parent.height
                    color: _colors.uTransparent

                    Rectangle {
                        color: _colors.uLightGrey
                        height: parent.height
                        width: 2
                        anchors.right: parent.right
                    }
                }
                Rectangle {
                    id: configurationContainer
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

                            icons: ["Off", "Time", "BarChart"]
                            texts: ["", "", ""]
                        }
                    }
                    Rectangle {
                        id: scenarioContainer
                        width: editButton.width + deleteButton.width + combo.width + 10
                        height: 40
                        color: _colors.uTransparent
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: tabsContainer.bottom
                        anchors.topMargin: 20

                        UI.UComboBox {
                            id: combo
                            width: 400
                            height: 40
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: parent.left
                            itemListModel: [
                                                { value:"0", displayedValue:"Regular work schedule", iconId:""},
                                                { value:"1", displayedValue:"Weekend schedule", iconId:""},
                                                { value:"2", displayedValue:"Special day schedule", iconId:""},
                                                { value:"3", displayedValue:"Jif schedule", iconId:""}
                                            ]
                        }
                        UI.UButton {
                            id: editButton
                            width: 40
                            height: 40
                            iconId: "Pencil"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: combo.right
                            anchors.leftMargin: 5

                        }
                        UI.UButton {
                            id: deleteButton
                            width: 40
                            height: 40
                            iconId: "Trash"
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.left: editButton.right
                            anchors.leftMargin: 5

                            buttonColor: _colors.uDarkRed
                            buttonHoveredColor: _colors.uRed
                        }

                        z: 2
                    }

                    Rectangle {
                        id: tabsContentContainer
                        color: _colors.uTransparent
                        width: parent.width
                        anchors.top: scenarioContainer.bottom
                        anchors.bottom: parent.bottom
                        anchors.topMargin: 20

                        Scenario.UTaskWidget {
                            anchors.fill: parent
                        }
                    }
                }

            }
        }
    }




    function refresh(newDevice) {
    }
}
