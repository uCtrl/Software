import QtQuick 2.0

Rectangle {
    id: container
    color: _colors.uGreen
    width: Math.round(label.width + 16)
    height: 22
    radius: radiusSize

    anchors.verticalCenter: parent.verticalCenter

    property string text: ""

    function changeText(newText)
    {
        label.text = newText
    }

    Default {
        id: label
        text: container.text
        font.pointSize: 14
        font.bold: true
        color: _colors.uWhite
        height: parent.height
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
    }
}
