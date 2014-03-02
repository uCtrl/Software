import QtQuick 2.0


Rectangle {
    border.color: "crimson"
    height: cellText.height
    width: parent.width

    Text {
        id: cellText
        color: "blue"
        text: "This is a config cell with id #" + id
        font.family: "Helvetica"
        font.pointSize: 20
    }
}

