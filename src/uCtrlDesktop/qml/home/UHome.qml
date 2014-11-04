import QtQuick 2.0
import QtQuick.Controls 1.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

UI.UFrame {
    contentItem: Rectangle {
        width: 1000
        height: 2000

        //Switch demonstration
        Rectangle {
            id: switchDemo
            width: parent.width
            height: 500

            UI.USwitch {
                id: swDemo

                anchors.top: parent.top
                anchors.topMargin: 15

                anchors.left: parent.left
                anchors.leftMargin: 15
            }


        }


        // Button demonstrations
        Rectangle {
            id: buttonDemo
            width: parent.width
            height: 70
            anchors.top: tabDemo.bottom

            UI.UButton {
                id: firstButton
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Click me !")

                anchors.margins: 4

                onClicked: {
                    state = "DISABLED"
                }
            }

            UI.UButton {
                id: enabledButton
                anchors.top: firstButton.bottom
                anchors.left: parent.left
                width: 150

                text: "Enabled button"
                state: "ENABLED"

                anchors.margins: 4
            }

            UI.UButton {
                id: disabledButton
                anchors.top: firstButton.bottom
                anchors.left: enabledButton.right
                width: 150
                text: "Disabled button"
                state: "DISABLED"

                anchors.margins: 4
            }

            UI.UButton {
                id: errorButton
                anchors.top: firstButton.bottom
                anchors.left: disabledButton.right
                width: 150
                text: "Error button"
                state: "ERROR"

                anchors.margins: 4
            }

            UI.UButton {
                id: iconButton
                anchors.top: firstButton.bottom
                anchors.left: errorButton.right
                width: 150
                iconId: "Time"
                text: ""
                state: "ENABLED"

                anchors.margins: 4
            }

            UI.UButton {
                id: iconAndTextButton
                anchors.top: firstButton.bottom
                anchors.left: iconButton.right
                width: 200
                iconId: "Time"
                text: "Time"
                state: "ENABLED"

                anchors.margins: 4
            }
        }
    }
}
