import QtQuick 2.0

Rectangle {

    color: "#3C3C3C"
    width: 67;

    property variant pages: []
    Column {
        anchors.fill: parent

        Repeater {
            model: pages
            Rectangle {
                height: 40

                anchors.left: parent.left
                anchors.right: parent.right

                Text {
                    text: modelData.charAt(0)

                    color: "#EDEDED"

                    font.bold: true
                    font.pixelSize: 24

                    anchors.centerIn: parent
                }

                color: "#3C3C3C"

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        main.currentPage = modelData;
                    }
                }
            }
        }
    }
}
