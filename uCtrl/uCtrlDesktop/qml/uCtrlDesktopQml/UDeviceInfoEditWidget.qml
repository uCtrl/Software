import QtQuick 2.0

Rectangle {
    property string uValue: "UNKNOWN"
    property string editColorZone: "transparent"
    property bool notAcceptInput: true
    property bool showCursor: false

    width: 322
    height: editZone.height
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    color: "transparent"

    Rectangle {
        id: infoPaddinIcon
        width: 5
        height: parent.height
        anchors.right: editZone.left
        color: "transparent"
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
            text: uValue

            readOnly: notAcceptInput
            cursorVisible: showCursor
        }
    }

    Image {
        id: editImage
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: infoPaddinIcon.left

        source: "qrc:///Resources/Images/pencil.svg"
    }

    MouseArea {
        height: parent.height
        anchors.left: editImage.left
        anchors.right: editImage.right

        onClicked: startStopEdit()
        cursorShape: "PointingHandCursor"
    }

    function startStopEdit() {
        if (editColorZone == "transparent") {
            editInput.focus = true;
            notAcceptInput = false;
            showCursor = true;
            editColorZone = "white";
        } else {
            editInput.focus = false;
            parent.focus = true;
            showCursor = false;
            editColorZone = "transparent";
            notAcceptInput = true;
        }
    }
}
