import QtQuick 2.0

import "../ui" as UI

Rectangle {
    id: titlebar
    color: "#0D9B0D"
    height: 65

    UI.UImage {
        id: homeBtn
        width: 80
        height: 45

        anchors.verticalCenter: parent.verticalCenter

        anchors.left: parent.left
        anchors.leftMargin: 12

        img: "../img/uCtrl-white.svg"
    }
}
