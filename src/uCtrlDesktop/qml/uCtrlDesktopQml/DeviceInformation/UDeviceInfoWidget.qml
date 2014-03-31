import QtQuick 2.0
import "../UI" as UI
import "../Device" as Device

UI.UFrame {
    property var device: null
    requiredModel: true

    function refresh(newDevice) {
        device = newDevice
        deviceHeader.refresh(device)
    }

    contentItem: Rectangle {
        Device.UHeader {
            id: deviceHeader

            device: device
        }

        Rectangle {
            width: parent.width
            anchors.top: deviceHeader.bottom
            color: _colors.uWhite

            UDeviceInfoCell {
                id: nameCase
                anchors.top: parent.top
                title: qsTr("Name :")

                UDeviceInfoEdit {
                    text: "Left bedside table"
                }
            }

            UDeviceInfoCell {
                id: roomCase
                anchors.top: nameCase.bottom
                title: qsTr("Room :")

                UDeviceInfoEdit {
                    text: "Master chamber"
                }
            }

            UDeviceInfoCell {
                id: typeCase
                anchors.top: roomCase.bottom
                title: qsTr("Type :")

                UDeviceInfoEdit {
                    text: "Light"
                }
            }

            UDeviceInfoCell {
                id: stateCase
                anchors.top: typeCase.bottom
                title: qsTr("State :")

                UDeviceInfoFixed {
                    text: "Close"
                }
            }

            UDeviceInfoCell {
                id: macCase
                anchors.top: stateCase.bottom
                title: qsTr("MAC address :")

                UDeviceInfoFixed {
                    text: "00:11:22:33:44:55:66:77"
                }
            }

            UDeviceInfoCell {
                id: ipCase
                anchors.top: macCase.bottom
                title: qsTr("IP address :")

                UDeviceInfoFixed {
                    text: "127.0.0.1"
                }
            }

            UDeviceInfoCell {
                id: idCase
                anchors.top: ipCase.bottom
                title: qsTr("ID  :")

                UDeviceInfoFixed {
                    text: "C3PO"
                }
            }

            UDeviceInfoCell {
                id: firmwareVCase
                anchors.top: idCase.bottom
                title: qsTr("Firmware version :")

                UDeviceInfoFixed {
                    text: "0.0.1 Alpha R0"
                }
            }
        }
    }
}
