import QtQuick 2.0

Rectangle {
    width: parent.width
    anchors.top: navigationBar.bottom
    color: "transparent"

    UDeviceInformationCaseWidget {
        id: nameCase
        anchors.top: parent.top
        title: "Name :"

        UDeviceInformationEditWidget {
            uValue: "Lampe de chevet gauche"
        }
    }

    UDeviceInformationCaseWidget {
        id: roomCase
        anchors.top: nameCase.bottom
        title: "Room :"

        UDeviceInformationEditWidget {
            uValue: "Chambre des maîtres"
        }
    }

    UDeviceInformationCaseWidget {
        id: typeCase
        anchors.top: roomCase.bottom
        title: "Type :"

        UDeviceInformationEditWidget {
            uValue: "Light"
        }
    }

    UDeviceInformationCaseWidget {
        id: stateCase
        anchors.top: typeCase.bottom
        title: "State :"

        UDeviceInformationFixedWidget {
            uValue: "Close"
        }
    }

    UDeviceInformationCaseWidget {
        id: macCase
        anchors.top: stateCase.bottom
        title: "MAC address :"

        UDeviceInformationFixedWidget {
            uValue: "00:11:22:33:44:55:66:77"
        }
    }

    UDeviceInformationCaseWidget {
        id: ipCase
        anchors.top: macCase.bottom
        title: "IP address :"

        UDeviceInformationFixedWidget {
            uValue: "127.0.0.1"
        }
    }

    UDeviceInformationCaseWidget {
        id: idCase
        anchors.top: ipCase.bottom
        title: "ID :"

        UDeviceInformationFixedWidget {
            uValue: "C3PO"
        }
    }

    UDeviceInformationCaseWidget {
        id: firmwareVCase
        anchors.top: idCase.bottom
        title: "Firmware version :"

        UDeviceInformationFixedWidget {
            uValue: "0.0.1 Alpha R0"
        }
    }
}
