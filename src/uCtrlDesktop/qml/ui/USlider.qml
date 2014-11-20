import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2
import "UColors.js" as Colors

Slider
{
    style: SliderStyle {
            groove: Rectangle {
                implicitHeight: 6
                implicitWidth: 100
                radius: height/2
                border.color: Colors.uGrey
                color: Colors.uWhite
                Rectangle {
                    height: parent.height
                    width: styleData.handlePosition
                    implicitHeight: 6
                    implicitWidth: 100
                    radius: height/2
                    color: Colors.uGreen
                }
            }
        }
}
