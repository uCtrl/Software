import QtQuick 2.0

Rectangle {

    color: "white"

    property variant model: null

    ListView {
        id: devices
        anchors.fill: parent
        model: parent.model
        delegate: Column {
            width: parent.width
            Rectangle {
                width: parent.width
                height: 40

                color: "white"

                Rectangle {
                    id: itemIcon

                    width: 30

                    anchors.left: parent.left

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10

                    radius: 2

                    color: "#0D9B0D"
                }

                Rectangle {
                    id: itemChevron

                    width: 30

                    anchors.right: parent.right

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 10

                    radius: 2

                    color: "#D4D4D4"
                }

                Text {
                    text: description

                    color: "black"

                    font.bold: true
                    font.pixelSize: 18

                    anchors.verticalCenter: itemIcon.verticalCenter

                    anchors.left: itemIcon.right
                    anchors.leftMargin: 10

                    anchors.right: itemChevron.left
                    anchors.rightMargin: 10
                }

                Rectangle {
                    width: parent.width
                    height: 1

                    color: "#D4D4D4"

                    anchors.bottom: parent.bottom
                }
            }
        }
    }

    /*
        delegate: Column {
            width: parent.width
            height: 20

            Text {
                text: id + " | " + type + " | " + description + " | " + isEnabled + " | " + isTriggerValue + " | " + maxValue + " | " + minValue + " | " + name + " | " + precision + " | " + status + " | " + unitLabel
                wrapMode: Text.WordWrap
                MouseArea {
                    anchors.fill: parent
                    height: parent.height; width: parent.width;
                    onClicked: {
                        console.log(id);
                    }
                }
            }
        }
   */
}
