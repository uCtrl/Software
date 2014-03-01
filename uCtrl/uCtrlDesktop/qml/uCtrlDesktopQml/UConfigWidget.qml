import QtQuick 2.0


Rectangle {
    color: "red"
    height: 70
    width: parent.width

    Text {
        property string labelText: "UNKNOWN"

        color: "blue"
        text: "this is something"
        font.family: "Helvetica"
        font.pointSize: 20
    }
}

