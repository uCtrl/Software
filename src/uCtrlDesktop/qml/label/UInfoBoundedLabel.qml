import QtQuick 2.0

Rectangle {
    id: container
    color: "#0D9B0D"
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
        color: "white"
        height: parent.height
        anchors.centerIn: parent
        verticalAlignment: Text.AlignVCenter
    }
}
