import QtQuick 2.0
import QtQuick.Controls 1.0

import "../UI" as UI
import "../UI/ULabel" as ULabel

UI.UFrame {
    contentItem: Rectangle {
        anchors.left: parent.left
        anchors.leftMargin: frameMarginSize

        anchors.top: parent.top
        anchors.topMargin: frameMarginSize

        width: (scrollView.width - (frameMarginSize *2))
        height: (scrollView.height - (frameMarginSize *2))

        color: _colors.uTransparent

        Rectangle {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -100
            width: voiceButton.width
            height: voiceButton.height + startLabel.height + startLabel.anchors.topMargin
            color: _colors.uTransparent

            UI.UButton {
                id: voiceButton

                width: 200
                height: 200
                radius: width * 0.5
                iconId: "Microphone"
                iconSize: 100

                onClicked: {
                    //Get mic input
                }
            }

            ULabel.Heading3 {
                id: startLabel

                anchors.top: voiceButton.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "Click to record"
            }
        }
    }
}
