import QtQuick 2.0
import "../ui/UColors.js" as Colors
import "../ui" as UI
import "../label" as ULabel

import UAudioRecorder 1.0
import UVoiceControl 1.0

Rectangle {
    id: content

    color: Colors.uLightGrey

    UAudioRecorder
    {
        id: audioRecorder
    }

    UVoiceControl
    {
        id: voiceControl

        onVoiceControlIntentChanged: {
            console.log("New intent : " + voiceControlIntent)
            var currentCommand = analyseIntent()

            if(currentCommand.getConfidence() >= 0.85)
            {
                commandLabel.text = "Command received: " + analyseResponse(currentCommand)
                //TODO: Send the command to NinjaWare
            }
            else if(currentCommand.getConfidence() >= 0.2)
            {
                commandLabel.text = "Did you mean: " + analyseResponse(currentCommand) + "?"
                didYouMeanAnswerContainer.visible = true
            }
            else
            {
                commandLabel.text = "We could not identify your command. Please try again."
            }
        }

        function analyseResponse(currentCommand) {
            if(currentCommand.getIntent() === "set_ninja_eyes_color")
            {
                return "Set ninja eyes to {color}";
            }
            if(currentCommand.getIntent() === "turn_onoff_plug_with_id")
            {
                return "Turn {on/off} plug with id {id}"
            }
            if(currentCommand.getIntent() === "turn_onoff_plug_in_location")
            {
                return "Turn {on/off} plug in location {location}"
            }
            if(currentCommand.getIntent() === "set_dimmer_lights_in_location")
            {
                return "Set dimmer lights in location {location} to {%}"
            }
            if(currentCommand.getIntent() === "turn_onoff_light_with_id")
            {
                return "Turn lights with id {id} "
            }
            if(currentCommand.getIntent() === "turn_onoff_lights_in_location")
            {
                return "Turn {on/off} lights in location {location}"
            }

            return "Unknown command";
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
