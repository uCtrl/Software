import QtQuick 2.0

Rectangle {
    property string img: "unknown"
    id: imageContainer
    color: "transparent"

    Image {
        width: parent.width
        height: parent.height

        source: img
        anchors.centerIn: parent

        fillMode: Image.PreserveAspectFit
    }

}
