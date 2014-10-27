import QtQuick 2.0
import "../ui/UColors.js" as Colors

Rectangle {
    id: container
    color: Colors.uGreen
    width: Math.round(label.width + 16)
    height: 22
    radius: 4

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
        color: Colors.uWhite
        height: parent.height
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
    }
}
