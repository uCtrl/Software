import QtQuick 2.0
import "../ui/UColors.js" as Colors

Rectangle {
    id: container

    property int boundedHeight: 8
    property int boundedWidth: 40
    property int boundedTextSize: 14
    property string boundedColor: Colors.uGreen

    color: boundedColor
    width: Math.round(label.width + boundedWidth)
    height: Math.round(label.height + boundedHeight)
    radius: 5

    anchors.verticalCenter: parent.verticalCenter

    property string text: ""

    function changeText(newText)
    {
        label.text = newText
    }

    Default {
        id: label
        text: container.text
        font.pointSize: boundedTextSize
        font.bold: true
        color: Colors.uWhite
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
    }
}
