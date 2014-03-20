import QtQuick 2.0
import "../UI" as UI
import "../Device" as Device

UI.UFrame {
    property variant device: null
    title: qsTr("Information")


    Device.UHeader {
        id: deviceHeader

        device: device
    }

    Rectangle {
        width: parent.width
        anchors.top: deviceHeader.bottom
        color: _colors.uTransparent

        UDeviceInfoCell {
            id: nameCase
            anchors.top: parent.top
            title: qsTr("Name :")

            UDeviceInfoEdit {
                textValue: "Left bedside table"
            }
        }

        UDeviceInfoCell {
            id: roomCase
            anchors.top: nameCase.bottom
            title: qsTr("Room :")

            UDeviceInfoEdit {
                textValue: "Master chamber"
            }
        }

        UDeviceInfoCell {
            id: typeCase
            anchors.top: roomCase.bottom
            title: qsTr("Type :")

            UDeviceInfoEdit {
                textValue: "Light"
            }
        }

        UDeviceInfoCell {
            id: stateCase
            anchors.top: typeCase.bottom
            title: qsTr("State :")

            UDeviceInfoFixed {
                textValue: "Close"
            }
        }

        UDeviceInfoCell {
            id: macCase
            anchors.top: stateCase.bottom
            title: qsTr("MAC address :")

            UDeviceInfoFixed {
                textValue: "00:11:22:33:44:55:66:77"
            }
        }

        UDeviceInfoCell {
            id: ipCase
            anchors.top: macCase.bottom
            title: qsTr("IP address :")

            UDeviceInfoFixed {
                textValue: "127.0.0.1"
            }
        }

        UDeviceInfoCell {
            id: idCase
            anchors.top: ipCase.bottom
            title: qsTr("ID  :")

            UDeviceInfoFixed {
                textValue: "C3PO"
            }
        }

        UDeviceInfoCell {
            id: firmwareVCase
            anchors.top: idCase.bottom
            title: qsTr("Firmware version :")

            UDeviceInfoFixed {
                textValue: "0.0.1 Alpha R0"
            }
        }
    }
}
