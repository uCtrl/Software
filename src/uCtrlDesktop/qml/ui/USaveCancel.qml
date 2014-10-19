import QtQuick 2.0

Rectangle {
    id: saveCancel
    width: saveButton.width + cancelButton.width + 5
    height: 30

    color: "transparent"

    property bool saveEnabled: true

    signal save
    signal cancel

    UButton {
        id: saveButton
        iconId: "Ok"

        anchors.left: parent.left
        anchors.leftMargin: 10
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

        buttonColor: "#A60E0E"
        buttonHoveredColor: "#D90E0E"

        onClicked: {
            saveCancel.cancel()
        }
    }
}
