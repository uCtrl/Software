import QtQuick 2.0

UConfigConditionWidget {
    property real conditionHour : 12
    property real conditionMinute : 15
    Rectangle{
        id: container
        width: parent.width - 30
        height: parent.height - 5
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: parent.verticalCenter

        color: "white"

        Rectangle{
            id: clockContainer
            width: parent.height
            height: parent.height

            UClock {
                anchors.left: parent.left
                clockHour: conditionHour
                clockMinute: conditionMinute
            }
        }
    }

}
