import QtQuick 2.0
import "../UI" as UI

Rectangle {

    function resetBreadcrumb() {
        brdCrumb.resetBreadcrumb()
    }

    function changeBreadcrumb(path, title, model) {
        brdCrumb.changeBreadcrumb(path, title, model)
    }

    id: titlebar

    color: _colors.uGreen
    height: 65

    UI.UImage {
        id: homeBtn
        width: 80
        height: 45

        anchors.verticalCenter: parent.verticalCenter

        anchors.left: parent.left
        anchors.leftMargin: 12

        img: "qrc:///Resources/Images/uCtrl-white.svg"
    }

    Rectangle {
        anchors.fill: parent
        color: _colors.uTransparent

        UI.UBreadcrumb {
            id: brdCrumb
        }
    }
}
