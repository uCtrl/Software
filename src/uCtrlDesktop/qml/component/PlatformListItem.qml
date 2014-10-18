import QtQuick 2.0
Rectangle {

    property var platformName: "Platform name"
    property var marginSize: 10

    width: parent.width
    height: parent.height

    color: "transparent"

    Rectangle {
        id: container

        width: parent.width
        height: parent.height

        anchors.verticalCenter: parent.verticalCenter

        color: getColor()

        Text {
            id: platformNameText

            x: marginSize; y: marginSize

            text: platformName

            color: "black"

            font.bold: true
            font.pixelSize: 18
        }

        Text {
            id: platformUpdateText

            x: marginSize

            text: "Updated a second ago."

            color: "#737373"

            font.bold: false
            font.pixelSize: 10

            anchors.top: platformNameText.bottom
        }

        Rectangle {
            id: platformSeparator

            width: parent.width
            height: 1

            anchors.bottom: parent.bottom

            color: "#D4D4D4"
        }

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                platformInfo.model = model
                platforms.currentIndex = index
            }
        }

        function getColor() {
            if (mouseArea.containsMouse) return "#EDEDED"
            else return "white"
        }
    }
}
