import QtQuick 2.0
import "../Device" as Device
import "../UI" as UI

UI.UFrame {
    property var device: null

    contentItem: Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right

        width: parent.width

        Device.UHeader {
            device: myDevice
            showConfig: true
            showInfo: true
        }
    }
}
