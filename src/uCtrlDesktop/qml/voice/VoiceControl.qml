import QtQuick 2.0
import "../ui/UColors.js" as Colors
import "../ui" as UI
import "../label" as ULabel

import UAudioRecorder 1.0
import UVoiceControl 1.0

Rectangle {
    id: content

    color: Colors.uLightGrey

    property variant currentCommand

    UAudioRecorder
    {
        id: audioRecorder
    }

    UVoiceControl
    {
        id: voiceControl
        uCtrlApiFacadeObject: uCtrlApiFacade

        onVoiceControlIntentChanged: {
            console.log("New intent : " + voiceControlIntent)
            currentCommand = analyseIntent()

            if(currentCommand.isVeryConfident())
            {
                commandLabel.text = "Command received: " + currentCommand.getCommand()
                currentCommand.sendIntent()
            }
            else if(currentCommand.isUnsure())
            {
                commandLabel.text = "Did you mean: " + currentCommand.getCommand() + "?"
                didYouMeanAnswerContainer.visible = true
            }
            else
            {
                commandLabel.text = "We could not identify your command. Please try again."
            }
        }
    }

    Rectangle
    {
        id: voiceControlContainer
        anchors.centerIn: parent
        height: voiceControlButtonContainer.height + commandLabel.height

        width: parent.width * 0.95
        color: Colors.uTransparent

        Rectangle
        {
            id: voiceControlButtonContainer
            width: 300
            height: 300
            radius: width * 0.5
            color: Colors.uTransparent

            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle
            {
                id: voiceControlAnimation
                width: 200
                height: 200
                radius: width * 0.5
                color: Colors.uWhite
                anchors.centerIn: parent

                PropertyAnimation {
                    id: voiceControlColorAnimation
                    target: voiceControlAnimation
                    properties: "color"
                    from: Colors.uGreen
                    to: Colors.uLightGrey
                    duration: 1000
                    loops: Animation.Infinite
                }
                PropertyAnimation {
                    id: voiceControlSizeAnimation
                    target: voiceControlAnimation
                    properties: "width, height"
                    from: 200
                    to: 300
                    duration: 1000
                    easing.type: Easing.OutQuad
                    loops: Animation.Infinite
                }
            }

            Rectangle
            {
                id: voiceControlButton
                width: 200
                height: 200
                radius: width * 0.5
                color: Colors.uGreen
                anchors.centerIn: parent

                property bool startedRecording: false;

                UI.UFontAwesome
                {
                    iconId: "Microphone"
                    iconSize: 64
                    iconColor: Colors.uWhite
                    anchors.centerIn: parent
                }

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered: {
                        voiceControlButton.color = Colors.uDarkGrey
                    }
                    onExited: {
                        voiceControlButton.color = Colors.uGreen
                    }
                    onClicked: {
                        if (messageCheckbox.checked)
                            voiceControl.sendMessage(messageTextbox.text)
                        else
                        {
                            voiceControlButton.startedRecording = !voiceControlButton.startedRecording

                            if(voiceControlButton.startedRecording)
                            {
                                didYouMeanAnswerContainer.visible = false

                                voiceControlColorAnimation.start()
                                voiceControlSizeAnimation.start()

                                commandLabel.text = "Recording your command..."
                            }
                            else
                            {
                                voiceControlColorAnimation.stop()
                                voiceControlSizeAnimation.stop()

                                voiceControlAnimation.width = 200
                                voiceControlAnimation.height = 200

                                commandLabel.text = "Analyzing your command..."

                                voiceControl.sendVoiceControlFile(audioRecorder.getOutputLocation())
                            }

                            audioRecorder.toggleRecord()
                        }
                    }
                }
            }
        }

        ULabel.Default
        {
            id: commandLabel
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: voiceControlButtonContainer.bottom
            width: parent.width * 0.75

            text: "Click the button and say a command"
            horizontalAlignment: Text.AlignHCenter
            color: Colors.uDarkGrey
            font.pointSize: 24
        }

        Rectangle
        {
            anchors.horizontalCenter: commandLabel.horizontalCenter
            anchors.top: commandLabel.bottom
            width: commandLabel.width * 0.75

            UI.UCheckbox
            {
                id: messageCheckbox
                anchors.left: parent.left
                anchors.verticalCenter: messageTextbox.verticalCenter
            }

            UI.UTextbox
            {
                id: messageTextbox
                anchors.top: commandLabel.bottom
                anchors.left: messageCheckbox.right
                anchors.right: parent.right
                anchors.leftMargin: 10
            }
        }


    }

    Rectangle
    {
        id: didYouMeanAnswerContainer
        width: 225
        anchors.top: voiceControlContainer.bottom
        anchors.topMargin: 10
        anchors.horizontalCenter: parent.horizontalCenter
        color: Colors.uTransparent

        visible: false

        UI.UButton
        {
            id: yesButton

            text: "Yes"
            iconId: "Ok"
            iconSize: 16
            buttonColor: Colors.uGreen
            buttonHoveredColor: Colors.uMediumLightGreen
            buttonTextColor : Colors.uWhite

            onClicked: {
                //TODO: Send the command to NinjaWare
                currentCommand.sendIntent()
                commandLabel.text = "Command sent to NinjaWare."
                didYouMeanAnswerContainer.visible = false
            }
        }

        UI.UButton
        {
            id: noButton

            text: "No"
            iconId: "Remove"
            iconSize: 16
            buttonColor: Colors.uDarkRed
            buttonHoveredColor: Colors.uRed
            buttonTextColor : Colors.uWhite

            anchors.right: parent.right

            onClicked: {
                commandLabel.text = "Click the button and say a command"
                didYouMeanAnswerContainer.visible = false
            }
        }
    }
}
