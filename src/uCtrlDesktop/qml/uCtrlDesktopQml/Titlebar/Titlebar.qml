import QtQuick 2.0
import "../UI" as UI

Rectangle {
    property variant breadCrumbLinks: ["A", "B", "C", "D"]

    id: titlebar

    color: _colors.uGreen
    height: 75

    UI.UImage {
        id: homeBtn
        width: 100
        height: 50

        anchors.verticalCenter: parent.verticalCenter

        anchors.left: parent.left
        anchors.leftMargin: 25

        img: "qrc:///Resources/Images/uCtrl-small-white.png"
    }

    Rectangle {
        anchors.fill: parent
        color: _colors.uTransparent

        UI.UBreadcrumb {
            id: brdCrumb
            links: breadCrumbLinks
        }
    }
}
