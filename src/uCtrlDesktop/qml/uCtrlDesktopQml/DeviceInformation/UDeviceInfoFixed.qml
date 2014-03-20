import QtQuick 2.0
import "../UI" as UI

UI.ULabel {
    property string textValue: "UNKNOWN"

    width: 322
    anchors.verticalCenter: parent.verticalCenter
    anchors.right: parent.right
    text: textValue
}
