import QtQuick 2.0
import "../UI" as UI


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

        color: _colors.uTransparent

        Rectangle{
            id: clockContainer

            width: parent.height
            height: parent.height

            color: _colors.uTransparent

            UClock {
                anchors.left: parent.left

                clockHour: conditionHour
                clockMinute: conditionMinute
            }
        }
        UI.ULabel {
            id: conditionLabel

            anchors.left: clockContainer.right
            anchors.leftMargin: 5
            anchors.verticalCenter: parent.verticalCenter

            text: "Time is later than " + conditionHour + ":" + zeroPad(conditionMinute, 2)
            color: _colors.uBlack
            font.pointSize: 14

            function zeroPad(num, numZeros) {
                var n = Math.abs(num);
                var zeros = Math.max(0, numZeros - Math.floor(n).toString().length );
                var zeroString = Math.pow(10,zeros).toString().substr(1);
                if( num < 0 ) {
                    zeroString = '-' + zeroString;
                }

                return zeroString+n;
            }
        }
    }
}
