import QtQuick 2.0
import "../UI" as UI

UI.ULabel {
    property string labelText: "UNKNOWN"

    text: labelText
    headerStyle: 3

    Component.onCompleted: {
        color = _colors.uGreen
        font.bold = true
    }
}
