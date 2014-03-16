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
        color: "white"
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
        color = colors.uLightGrey
        border.color = colors.uGrey
        buttonLabel.color = colors.uDarkGrey
    }

    function setEnabled() {
        enabled = true
        color = colors.uGreen
        border.color = colors.uDarkGreen
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
