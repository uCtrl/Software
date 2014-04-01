import QtQuick 2.0
import "../UI" as UI


Rectangle{
    id: container

    width: parent.width - 30
    height: parent.height - 5

    anchors.left: parent.left
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    color: _colors.uTransparent

    Rectangle{
        id: calendar

        width: parent.height
        height: parent.height

        color: _colors.uGreen
    }

    UI.ULabel {
        id: dateLabel

        anchors.left: calendar.right
        anchors.leftMargin: 5
        anchors.verticalCenter: parent.verticalCenter

        text: getDate()
        color: _colors.uBlack
        font.pointSize: 14

        function getDate() {
            var d = conditionModel.beginDate
            return Qt.formatDate(d, "ddd dd MMM")
        }
    }
}
