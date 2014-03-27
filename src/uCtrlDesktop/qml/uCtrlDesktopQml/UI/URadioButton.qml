import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

RadioButton {
    id: radiobutton
    width: 1000
    height: 35

    anchors.margins: 4
    state: "NORMAL"
    color: _colors.uWhite

    function execute() {
        console.log("I clicked on thie radio button")
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            if (state != "DISABLED") parent.execute()
        }
    }

    states: [
        State {
            name: "NORMAL"
            PropertyChanges { target: radiobutton; color: _colors.uWhite }
        },

        State {
            name: "DISABLED"
            PropertyChanges { target: radiobutton; color: _colors.uLightGrey }
        }

    ]
}
