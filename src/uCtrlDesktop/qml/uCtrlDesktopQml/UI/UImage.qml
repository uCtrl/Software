import QtQuick 2.0

Rectangle {
    id: imageContainer

    property string img: "unknown"

    color: "transparent"

    Image {
        width: parent.width
        height: parent.height

        source: img
        anchors.centerIn: parent

        fillMode: Image.PreserveAspectFit
    }

}
