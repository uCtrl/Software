import QtQuick 2.0
import "../UI" as UI
import "../Device" as Device

UI.UFrame {
    property var device: null

    id: infoDevide
    requiredModel: true

    function refresh(newDevice) {
        infoDevide.device = newDevice
        deviceHeader.refresh(infoDevide.device)
    }

    contentItem: Rectangle {
        anchors.top: parent.top
        anchors.left: parent.left

        color: _colors.uLightGrey
        width: infoDevide.width;
        height: infoDevide.height

        Device.UHeader {
            id: deviceHeader

            device: infoDevide.device
        }

        Rectangle {
            clip:true

            anchors.top: deviceHeader.bottom
            anchors.bottom: parent.bottom

            width: parent.width

            color: _colors.uTransparent
            visible: true

            ListView {
                id: infoList
                anchors.fill: parent

                model: infoDevide.device ? infoDevide.device.getDeviceInfo() : null

                delegate: UDeviceInfoCell {
                    title: infoDevide.device.getDeviceInfo().getDeviceInfoFieldsKeys()[index]
                    value: infoDevide.device.getDeviceInfo().getDeviceInfoFields()[title]["value"]
                    isEditable: infoDevide.device.getDeviceInfo().getDeviceInfoFields()[title]["isEditable"]
                }
            }
        }
    }
}
