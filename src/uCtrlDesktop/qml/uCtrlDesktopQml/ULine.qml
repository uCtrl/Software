import QtQuick 2.0

Rectangle {
    property real lineLength: 10
    property real rotationDegrees: 0
    property int thickness: 2

    color: "black"
    height: thickness
    transformOrigin: Item.Left
    antialiasing: true
    width: lineLength
    rotation: rotationDegrees
}
