import QtQuick 2.0
import "../UI" as UI

Rectangle {
    id: deviceInfo
    property string text: "UNKNOWN"
    property color editColorZone: _colors.uTransparent
    property bool editReadOnly: true
    property bool showCursor: false

    width: 322
    height: editZone.height
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    color: editColorZone

    Rectangle {
        id: infoPaddingIcon
        width: 5
        height: parent.height
        anchors.right: editZone.left
        color: _colors.uTransparent
    }

    Rectangle {
        id: editZone
        width: 322
        height: 22
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        color: editColorZone

        TextInput {
            id: editInput
            width: parent.width
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            text: deviceInfo.text

            readOnly: editReadOnly
            cursorVisible: showCursor
        }
    }

    UI.UImage {
        id: editImage
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: infoPaddingIcon.left

        width: 16; height: 16

        img: "qrc:///Resources/Images/pencil.svg"
    }

    MouseArea {
        height: parent.height
        anchors.left: editImage.left
        anchors.right: editImage.right

        onClicked: startStopEdit()
        cursorShape: "PointingHandCursor"
    }

    function startStopEdit() {
        if (editReadOnly) {
            editReadOnly = false;
            editColorZone = _colors.uWhite;
        } else {
            editColorZone = _colors.uTransparent;
            editReadOnly = true;
        }
    }
}
