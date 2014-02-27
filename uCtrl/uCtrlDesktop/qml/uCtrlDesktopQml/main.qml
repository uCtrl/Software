import QtQuick 2.0

Rectangle {
    width: 360
    height: 600
    color: "lightgray"
    Text {
        id: helloText
        text: qsTr("Hello World")
        anchors.centerIn: parent
    }

    UHeaderBarWidget {}
}
