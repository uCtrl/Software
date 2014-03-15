import QtQuick 2.0
import "../UI" as UI

UI.UFrame {
    title: "Homepage"
    anchors.horizontalCenter: parent.horizontalCenter

    Item {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        UI.UButton {
            id: firstButton
            displayedText: "Click me !"
            width: 96; height: 27
            anchors.top: parent.top
            anchors.topMargin: 7
            anchors.horizontalCenter: parent.horizontalCenter
            function execute() {
                setDisabled()
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height - firstButton.height - (7 + 3)
            color: "transparent"

            anchors.top: firstButton.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: 8

            UI.ULabel {
                id: title
                anchors.left: parent.left
                label: "UI.ULabel demonstration"
                headerStyle: 1
            }

            UI.ULabel {
                id: boldText
                anchors.top: title.bottom
                anchors.topMargin: 5
                anchors.left: parent.left
                label: "Hello, I am <b>bold</b> !"
            }

            UI.ULabel {
                id: longText
                width: parent.width

                label: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.
                        Sed et commodo magna. Mauris posuere dolor in tristique iaculis. Suspendisse lacinia suscipit diam, nec malesuada metus mollis in.
                        Sed lobortis euismod ipsum a consequat. Donec tempor porttitor urna id viverra. Quisque a quam vitae nisl gravida dapibus.
                        Mauris consequat nibh eu risus pellentesque, vitae pharetra lectus ultricies. Proin vel eros hendrerit, convallis magna at, rhoncus orci.
                        Nulla adipiscing nec mauris id tempor."
                anchors.top: boldText.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
                justified: true
            }

            UI.ULabel {
                id: h1
                width: parent.width

                label: "h1. Heading 1"
                anchors.top: longText.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
                headerStyle: 1
            }

            UI.ULabel {
                id: h2
                width: parent.width

                label: "h2. Heading 2"
                anchors.top: h1.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
                headerStyle: 2
            }

            UI.ULabel {
                id: h3
                width: parent.width

                label: "h3. Heading 3"
                anchors.top: h2.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
                headerStyle: 3
            }

            UI.ULabel {
                id: h4
                width: parent.width

                label: "h4. Heading 4"
                anchors.top: h3.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
                headerStyle: 4
            }

            UI.ULabel {
                id: h5
                width: parent.width

                label: "h5. Heading 5"
                anchors.top: h4.bottom
                anchors.left: parent.left
                anchors.topMargin: 5
                headerStyle: 5
            }
        }
    }
}
