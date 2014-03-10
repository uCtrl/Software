import QtQuick 2.0

Rectangle {
    property string scenarioName: "UNKNOWN #2"

    width: parent.width
    height: 30

    color: "#404040"
    border.width: 2
    border.color: "black"

    ULabel {
        text: scenarioName
        color: "white"
        font.pointSize: 11
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
    }
}
