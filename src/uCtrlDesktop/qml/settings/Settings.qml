import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: settingsPage
    color: Colors.uLightGrey

    Rectangle {
        id: settingsContainer
        anchors.fill: parent
        anchors.margins: 20
        color: Colors.uTransparent

        ULabel.Heading1 {
            id: ninjaSection
            text: "Ninja Blocks"
            color: Colors.uDarkGrey
        }

        ULabel.Default {
            id: ninjaServerUrlToken
            anchors.top: ninjaSection.bottom
            anchors.topMargin: 10

            text: "Server Base Url"
            color: Colors.uMediumDarkGrey
        }

        UI.UTextbox {
            id: ninjaServerUrlBox
            anchors.top: ninjaServerUrlToken.bottom

            height: 30
            width: 400

            text: uCtrlApi.serverBaseUrl
            onTextChanged: {
                uCtrlApi.serverBaseUrl = ninjaServerUrlBox.text
            }
        }


        ULabel.Default {
            id: ninjaTokenLabel
            anchors.top: ninjaServerUrlBox.bottom
            anchors.topMargin: 5

            text: "Ninja Blocks Token"
            color: Colors.uMediumDarkGrey
        }

        UI.UTextbox {
            id: ninjaTokenBox
            anchors.top: ninjaTokenLabel.bottom

            height: 30
            width: 400

            text: uCtrlApi.ninjaToken
            onTextChanged: {
                uCtrlApi.ninjaToken = ninjaTokenBox.text
            }
        }

        UI.UButton {
            id: syncButton
            anchors.top: ninjaTokenBox.bottom
            anchors.topMargin: 10

            buttonColor: Colors.uDarkGrey
            buttonHoveredColor: Colors.uMediumDarkGrey
            text: "Synchronize"
            onClicked: uCtrlApi.synchronize();
        }
    }
}
