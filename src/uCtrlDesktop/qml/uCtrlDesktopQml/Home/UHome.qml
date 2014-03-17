import QtQuick 2.0
import "../UI" as UI

UI.UFrame {
    title: "Homepage"
    anchors.horizontalCenter: parent.horizontalCenter

    Text {
        id: homeLabel
        text: "Homepage"
        color: colors.uGreen
    }

    Item {
        width: parent.width
        height: parent.height
        anchors.centerIn: parent

        UI.UButton {
            id: firstButton
            label: "Click me !"
            width: 96; height: 27
            anchors.top: parent.top
            anchors.topMargin: homeLabel.height + 3
            function execute() {
                setDisabled()
            }
        }

        UI.UComboBox {
            id: combo
        }
    }
}
