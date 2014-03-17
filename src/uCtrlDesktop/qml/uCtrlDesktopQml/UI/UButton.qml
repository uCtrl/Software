import QtQuick 2.0

Rectangle {
    property string displayedText: "UNKNOWN"
    property bool enabled: true

    signal click

    radius: 5
    border.width: 1

    ULabel {
        id: buttonLabel
        anchors.centerIn: parent
        font.bold: true
        label: displayedText

        Component.onCompleted: {
            applyHeadingStyle(5)
            centerHorizontally()
            buttonLabel.color = "white"
            buttonLabel.font.bold = true
        }
    }

    function setDisabled() {
        enabled = false
        color = _colors.uLightGrey
        border.color = _colors.uGrey
        buttonLabel.color = _colors.uDarkGrey
    }

    function setEnabled() {
        enabled = true
        color = _colors.uGreen
        border.color = _colors.uDarkGreen
        buttonLabel.color = "white"
    }

    Component.onCompleted: { setEnabled() }

    MouseArea {
        id: defaultArea
        anchors.fill: parent
        onClicked: click()
    }

    onClick: {
        if (enabled) this.execute()
    }

    function execute() {
        // @TODO : Change console log for alert
        console.log("Warning execute method not overriden")
    }
}
