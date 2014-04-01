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


        UI.UFontAwesome {
            iconId: "Calendar"
            iconSize: 26
            anchors.centerIn: parent
        }
        color: _colors.uTransparent
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
