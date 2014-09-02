import QtQuick 2.0

Rectangle {
    id: list

    property var devices: null

    clip: true

    radius: radiusSize

    color: _colors.uTransparent

    function refresh(newDevicesList) {
        devices = newDevicesList
    }

    ListView {
        id: devicesList

        anchors.fill: parent

        model: devices
        delegate: UDevice { }
    }
}
