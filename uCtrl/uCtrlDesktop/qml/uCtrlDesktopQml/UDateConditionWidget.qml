import QtQuick 2.0

UConfigConditionWidget {
    Rectangle{
        id: container
        width: parent.width - 30
        height: parent.height - 5
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.verticalCenter: parent.verticalCenter
        color: "transparent"

        Rectangle {
            width: parent.height
            height: parent.height
            color: "transparent"

            Image {
                id: calendarImage
                anchors.centerIn: parent
                height: parent.width
                width: parent.height
                source: "qrc:///Resources/Images/Calendar-Icon.png"
            }

            ULabel {
                id: conditionText
                text: "Day of the week is " + condition
                color: "black"
                font.pointSize: 14
                anchors.left: calendarImage.right
                anchors.leftMargin: 5
            }
        }
    }
}
