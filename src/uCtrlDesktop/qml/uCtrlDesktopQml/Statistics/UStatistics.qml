import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

UI.UFrame {
    id: statsFrame

    contentItem: Rectangle {
        ULabel.Default {
            text: qsTr("Hello World !")
            color: _colors.uGreen
        }
    }
}
