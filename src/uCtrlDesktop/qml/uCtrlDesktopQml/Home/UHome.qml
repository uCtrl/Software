import QtQuick 2.0
import "../UI" as UI

UI.UFrame {
    title: "Homepage"
    anchors.horizontalCenter: parent.horizontalCenter

    Text {
        text: "Homepage"
        color: colors.uGreen
    }

    UI.UButton {
        label: "Normal button"
        anchors.centerIn: parent
        width: 96; height: 27
    }

    Component.onCompleted: {
        visible: true
    }
}
