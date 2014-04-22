import QtQuick 2.0

Rectangle {
    id: imageContainer

    property string img: "unknown"

    color: _colors.uTransparent

    Image {
        width: parent.width
        height: parent.height

        source: img
        sourceSize.width: parent.width
        sourceSize.height: parent.height
        anchors.centerIn: parent
        smooth: false

        fillMode: Image.PreserveAspectFit
    }
}
