import QtQuick 2.0
import QtQuick.Controls 1.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

UI.UFrame {
    contentItem: Rectangle {
        width: 1000
        height: 1000

        Rectangle {
            id: buttonDemo
            width: parent.width
            height: 70
            anchors.top: parent.top

            UI.UButton {
                id: firstButton
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Click me !")

                function execute() {
                    state="DISABLED"
                }
            }

            UI.UButton {
                id: enabledButton
                anchors.top: firstButton.bottom
                anchors.left: parent.left
                width: 150

                text: "Enabled button"
                state: "ENABLED"
            }

            UI.UButton {
                id: disabledButton
                anchors.top: firstButton.bottom
                anchors.left: enabledButton.right
                width: 150
                text: "Disabled button"
                state: "DISABLED"
            }

            UI.UButton {
                id: errorButton
                anchors.top: firstButton.bottom
                anchors.left: disabledButton.right
                width: 150
                text: "Error button"
                state: "ERROR"
            }
        }
        Rectangle {
            id: labelDemo

            width: parent.width
            height: 400
            color: _colors.uTransparent

            anchors.top: buttonDemo.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 8

            ULabel.Heading1 {
                id: title

                anchors.left: parent.left

                text: "UI.ULabel.Heading1 demonstration"
            }

            ULabel.Default {
                id: boldText

                anchors.top: title.bottom
                anchors.topMargin: 5
                anchors.left: parent.left

                text: qsTr("Hello, I am <b>a default bold text</b> !")
            }

            ULabel.Default {
                id: longText

                width: parent.width
                text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        Sed et commodo magna. Mauris posuere dolor in tristique iaculis. Suspendisse lacinia suscipit diam, nec malesuada metus mollis in.
                        Sed lobortis euismod ipsum a consequat. Donec tempor porttitor urna id viverra. Quisque a quam vitae nisl gravida dapibus.
                        Mauris consequat nibh eu risus pellentesque, vitae pharetra lectus ultricies. Proin vel eros hendrerit, convallis magna at, rhoncus orci.
                        Nulla adipiscing nec mauris id tempor."

                anchors.top: boldText.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
                horizontalAlignment: Text.AlignJustify
            }

            ULabel.Heading1 {
                id: h1

                width: parent.width
                text: qsTr("h1. Heading 1")

                anchors.top: longText.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
            }

            ULabel.Heading2 {
                id: h2

                width: parent.width
                text: qsTr("h2. Heading 2")

                anchors.top: h1.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
            }

            ULabel.Heading3 {
                id: h3
                width: parent.width

                text: qsTr("h3. Heading 3")
                anchors.top: h2.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
            }

            ULabel.Heading4 {
                id: h4
                width: parent.width

                text: qsTr("h4. Heading 4")
                anchors.top: h3.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
            }

            ULabel.Heading5 {
                id: h5
                width: parent.width

                text: qsTr("h5. Heading 5")
                anchors.top: h4.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
            }
        }
        Rectangle {
            id: comboDemo
            width: parent.width
            height: 30

            anchors.top: labelDemo.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5

            UI.UComboBox {
                id: combo
            }
        }

        Rectangle {
            id: checkDemo
            width: parent.width
            height: 50

            anchors.top: comboDemo.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 5

            Rectangle {
                id: toggledCheckbox
                anchors.fill: parent

                UI.UCheckbox {
                    id: toggleEnable
                    text: "Toggle me with that button !"
                    anchors.verticalCenter: parent.verticalCenter
                }

                UI.UButton {
                    id: checkButton
                    anchors.right: parent.right
                    width: 70
                    text: (toggleEnable.state === "ENABLED" ? "Disable" : "Enable")

                    function execute() {
                        toggleEnable.state = (toggleEnable.state === "ENABLED" ? "DISABLED" : "ENABLED")
                    }
                }
            }

            UI.UCheckbox {
                id: errorCheckbox
                anchors.left: parent.left
                anchors.top: toggledCheckbox.bottom
                text: "Error state checkbox"
                state: "ERROR"
            }
        }

        Rectangle {
            anchors.top: checkDemo.bottom
            anchors.topMargin: 25
            width: parent.width
            height: 50

            ExclusiveGroup { id: firstGroup }
            UI.URadioButton {
                id: radio1
                state: {
                    if(radio6.checked)
                        return "DISABLED"
                    else
                        return "ENABLED"
                }

                anchors.top: parent.top
                exclusiveGroup: firstGroup
                text: "Radio 1"
            }
            UI.URadioButton {
                id: radio2
                state: {
                    if(radio6.checked)
                        return "DISABLED"
                    else
                        return "ENABLED"
                }

                anchors.top: parent.top
                anchors.left: radio1.right
                text: "Radio 2"
                exclusiveGroup: firstGroup
            }
            UI.URadioButton {
                id: radio3
                state: {
                    if(radio6.checked)
                        return "DISABLED"
                    else
                        return "ENABLED"
                }

                anchors.top: parent.top
                anchors.left: radio2.right
                text: "Radio 3"
                exclusiveGroup: firstGroup
            }


            ExclusiveGroup { id: secondGroup }
            UI.URadioButton {
                id: radio4
                state: {
                    if(radio5.checked)
                        return "DISABLED"
                    else if (radio6.checked)
                        return "ENABLED"
                    else
                        return "ENABLED"
                }

                anchors.top: radio1.bottom
                exclusiveGroup: secondGroup
                text: "Radio 1"
            }
            UI.URadioButton {
                id: radio5
                state: {
                    if(radio4.checked)
                        return "ERROR"
                    else if (radio6.checked)
                        return "ENABLED"
                    else
                        return "ENABLED"
                }

                anchors.top: radio1.bottom
                anchors.left: radio4.right
                text: "Radio 2"
                exclusiveGroup: secondGroup
            }
            UI.URadioButton {
                id: radio6
                state: {
                    if (radio4.checked)
                        return "ERROR"
                    else if (radio5.checked)
                        return "DISABLED"
                    else
                        return "ENABLED"
                }

                anchors.top: radio1.bottom
                anchors.left: radio5.right
                text: "Radio 3"
                exclusiveGroup: secondGroup
            }
        }
    }
}
