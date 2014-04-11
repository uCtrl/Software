import QtQuick 2.0

Rectangle {
    id: container
    color: _colors.uGreen
    width: label.width + 20
    height: 30
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
        font.pointSize: 16
        font.bold: true
        color: _colors.uWhite
        anchors.centerIn: parent
    }
}
