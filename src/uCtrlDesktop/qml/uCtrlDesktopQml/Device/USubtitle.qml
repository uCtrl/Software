import QtQuick 2.0
import "../UI" as UI

UI.ULabel {
    property string labelText: "UNKNOWN"

    font.family: "Helvetica neue"
    font.pointSize: 15
    color: colors.uDarkGrey
    text: labelText
}