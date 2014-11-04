import QtQuick 2.0

import "../ui" as UI
import "../ui/UColors.js" as Colors


Rectangle {
    id: titlebar

    color: Colors.uGreen
    height: 65

    UI.UImage {
        id: logo

        width: 80
        height: 45

        anchors.verticalCenter: parent.verticalCenter

        anchors.left: parent.left
        anchors.leftMargin: 12

        img: "../img/uCtrl-white.svg"
    }

    UI.UBreadCrumb{
        id: breadcrumb

        width: 200
        height: 45

        anchors.verticalCenter: parent.verticalCenter

        anchors.right: parent.right
        anchors.rightMargin: 12
    }

    function changePage(path, pageName){
        breadcrumb.changePage(path, pageName)
    }
}
