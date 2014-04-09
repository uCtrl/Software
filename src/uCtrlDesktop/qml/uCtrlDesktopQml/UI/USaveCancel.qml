import QtQuick 2.0

Rectangle {
    id: saveCancel
    width: saveButton.width + cancelButton.width + 5
    height: 30

    color: _colors.uTransparent

    property bool saveEnabled: true

    signal save
    signal cancel

    UButton {
        id: saveButton
        iconId: "Ok"

        anchors.left: parent.left
        state: saveEnabled ? "ENABLED" : "DISABLED"

        width: parent.height
        height: parent.height

        onClicked: {
            saveCancel.save()
        }
    }

    function changeSaveButtonState(newValue){
        saveButton.state = newValue ? "ENABLED" : "DISABLED"
    }

    UButton {
        id: cancelButton
        iconId: "Remove"
        anchors.left: saveButton.right
        anchors.leftMargin: 5

        width: parent.height
        height: parent.height

        buttonColor: _colors.uDarkRed
        buttonHoveredColor: _colors.uRed

        onClicked: {
            saveCancel.cancel()
        }
    }
}
