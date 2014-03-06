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

        color: "transparent"

        Rectangle{
            id: clockContainer
            width: parent.height
            height: parent.height
            color: "transparent"

            UClock {
                anchors.left: parent.left
                clockHour: conditionHour
                clockMinute: conditionMinute
            }
        }
        ULabel {
            id: conditionLabel
            anchors.left: clockContainer.right
            anchors.leftMargin: 5
            text: "Time is " + condition
            anchors.verticalCenter: parent.verticalCenter
            color: "black"
            font.pointSize: 14
        }


    }

}
