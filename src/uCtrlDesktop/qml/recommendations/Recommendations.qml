import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: recommandationsPage
    color: Colors.uLightGrey    

    Rectangle {
        id: recommandationsContainer
        anchors.fill: parent
        anchors.margins: 20
        color: Colors.uTransparent

        ULabel.Heading1 {
            id: recommendationsTitle
            text: "Recommendations"
            color: Colors.uDarkGrey
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        Rectangle {
            id: rectRecommendations
            z: 1
            anchors.left: parent.left; anchors.right: parent.right;
            anchors.top: recommendationsTitle.bottom; anchors.bottom: parent.bottom;
            anchors.margins: 5
            width: parent.width
            color: Colors.uWhite
            radius: 4

            ListView {
                id: recommendations
                clip: true
                anchors.fill: parent
                width: parent.width
                model: platformsModel.getRecommendations()

                delegate: Column {
                    width: parent.width
                    height: (resourceLoader.loadResource("recommandationsRecommandationsHeight"))

                    Rectangle {
                        id: rowContainer
                        height: parent.height; width: parent.width

                        ULabel.Default {
                            font.pointSize: 15
                            text: model.description
                            anchors.left: parent.left
                            anchors.leftMargin: 10
                            anchors.verticalCenter: parent.verticalCenter
                        }

                        Rectangle {
                            width: (resourceLoader.loadResource("recommandationsButtonsWidth"))
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.verticalCenterOffset: -acceptButton.height/2

                            UI.UButton {
                                id: acceptButton
                                anchors.right: declineButton.left
                                anchors.rightMargin: 10
                                text: "Accept"
                                height: (resourceLoader.loadResource("recommandationsAcceptButtonHeight"))
                                onClicked: {
                                    uCtrlApiFacade.acceptRecommendation(model.id, true)
                                }
                            }

                            UI.UButton {
                                id: declineButton
                                anchors.right: parent.right
                                anchors.rightMargin: 10
                                text: "Decline"
                                height: (resourceLoader.loadResource("recommandationsAcceptButtonHeight"))
                                buttonColor: Colors.uDarkGrey
                                buttonHoveredColor: Colors.uMediumDarkGrey
                                onClicked: {
                                    uCtrlApiFacade.acceptRecommendation(model.id, false)
                                }
                            }
                        }
                    }
                }
            }

            Rectangle {
               id: noRecommendation
               anchors.fill: parent
               visible: isNoRecommendationVisible();
               color: Colors.uTransparent

               Rectangle
               {
                   width: parent.width
                   height: noRecommendationLabel.height
                   anchors.centerIn: parent
                   ULabel.Default {
                       id: noRecommendationLabel
                       anchors.horizontalCenter: parent.horizontalCenter
                       text: "No recommendation available"
                       width: parent.width * 0.75
                       font.bold: true
                       font.pointSize: 32
                       horizontalAlignment: Text.AlignHCenter
                       color: Colors.uGrey
                   }
               }
            }
        }
    }

    Component.onCompleted: {
        var recPage = main.currentPage;
        uCtrlApiFacade.getRecommendations();
        main.onCurrentPageChanged.connect(function() {
            if (main.currentPage === recPage) {
                uCtrlApiFacade.getRecommendations();
            }
        });

        recommendations.model.onRowCountChanged.connect(function() {
            noRecommendation.visible = isNoRecommendationVisible();
        });
    }

    function isNoRecommendationVisible() {
        return !recommendations.model || (recommendations.model.rowCount === 0);
    }
}
