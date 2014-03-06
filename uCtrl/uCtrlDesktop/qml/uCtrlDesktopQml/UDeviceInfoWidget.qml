import QtQuick 2.0

Rectangle {
    width: parent.width
    color: "transparent"

    UDeviceInfoCaseWidget {
        id: nameCase
        anchors.top: parent.top
        title: "Name :"

        UDeviceInfoEditWidget {
            uValue: "Lampe de chevet gauche"
        }
    }

    UDeviceInfoCaseWidget {
        id: roomCase
        anchors.top: nameCase.bottom
        title: "Room :"

        UDeviceInfoEditWidget {
            uValue: "Chambre des maîtres"
        }
    }

    UDeviceInfoCaseWidget {
        id: typeCase
        anchors.top: roomCase.bottom
        title: "Type :"

        UDeviceInfoEditWidget {
            uValue: "Light"
        }
    }

    UDeviceInfoCaseWidget {
        id: stateCase
        anchors.top: typeCase.bottom
        title: "State :"

        UDeviceInfoFixedWidget {
            uValue: "Close"
        }
    }

    UDeviceInfoCaseWidget {
        id: macCase
        anchors.top: stateCase.bottom
        title: "MAC address :"

        UDeviceInfoFixedWidget {
            uValue: "00:11:22:33:44:55:66:77"
        }
    }

    UDeviceInfoCaseWidget {
        id: ipCase
        anchors.top: macCase.bottom
        title: "IP address :"

        UDeviceInfoFixedWidget {
            uValue: "127.0.0.1"
        }
    }

    UDeviceInfoCaseWidget {
        id: idCase
        anchors.top: ipCase.bottom
        title: "ID :"

        UDeviceInfoFixedWidget {
            uValue: "C3PO"
        }
    }

    UDeviceInfoCaseWidget {
        id: firmwareVCase
        anchors.top: idCase.bottom
        title: "Firmware version :"

        UDeviceInfoFixedWidget {
            uValue: "0.0.1 Alpha R0"
        }
    }
}
