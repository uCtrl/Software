import QtQuick 2.0
import QtQuick.Controls 1.0
import UAudioRecorder 1.0
import UVoiceControl 1.0

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
            id: voiceContainer

            anchors.centerIn: parent
            anchors.verticalCenterOffset: -100
            width: voiceButton.width
            height: voiceButton.height + recordLabel.height + recordLabel.anchors.topMargin
            color: _colors.uTransparent

            UI.UButton {
                id: voiceButton

                width: 200
                height: 200
                radius: width * 0.5
                iconId: "Microphone"
                iconSize: 100
                color: _colors.uDarkGrey
                onClicked: audioRecorder.toggleRecord()

                function onRecordingStarted() {
                    voiceButton.buttonColor = _colors.uDarkGrey
                    voiceButton.buttonHoveredColor = _colors.uDarkGreyHover
                }

                function onRecordingStopped() {
                    voiceButton.buttonColor = _colors.uGreen
                    voiceButton.buttonHoveredColor = _colors.uMediumLightGreen

                    voiceControl.sendVoiceControlFile(audioRecorder.getOutputLocation())
                }

                Component.onCompleted: {
                    audioRecorder.onRecordingStarted.connect(onRecordingStarted);
                    audioRecorder.onRecordingStopped.connect(onRecordingStopped);
                }
            }

            ULabel.Heading3 {
                id: recordLabel

                property string startRecordingLabel: "Click to start recording";
                property string stopRecordingLabel: "Click to stop recording";

                anchors.top: voiceButton.bottom
                anchors.topMargin: 10
                anchors.horizontalCenter: parent.horizontalCenter
                wrapMode: Text.WordWrap
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: startRecordingLabel

                function onRecordingStarted() {
                    recordLabel.text = stopRecordingLabel;
                }

                function onRecordingStopped() {
                    recordLabel.text = startRecordingLabel;
                }

                Component.onCompleted: {
                    audioRecorder.onRecordingStarted.connect(onRecordingStarted);
                    audioRecorder.onRecordingStopped.connect(onRecordingStopped);
                }
            }

            UAudioRecorder {
                id: audioRecorder
            }

            UVoiceControl {
                id: voiceControl

                onVoiceControlIntentChanged: {
                    console.log("New intent : " + voiceControlIntent)
                }
            }
        }
    }
}
