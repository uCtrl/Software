import QtQuick 2.0
import "../UI" as UI

UI.UFrame {
    id: statsFrame

    contentItem: Rectangle {
        Text {
            text: qsTr("Hello World !")
            color: _colors.uGreen
        }
    }
}
