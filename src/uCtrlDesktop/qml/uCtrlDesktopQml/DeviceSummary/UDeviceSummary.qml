import QtQuick 2.0
import "../Device" as Device
import "../UI" as UI

UI.UFrame {
    property variant device: null

    anchors.top: parent.top

    Device.UHeader {
        device: myDevice
        showConfig: true
        showInfo: true
    }
}