import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Controls.Styles 1.2

import "../label" as ULabel
import "UColors.js" as Colors

Slider
{
    property int textWidth: 100
    property int textSize: 20

    id: slider
    style: SliderStyle {
        groove: Rectangle {
            implicitHeight: (resourceLoader.loadResource("usliderSliderImplicitHeight"))
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

    signal newValue(var value);
    onPressedChanged: if (!pressed) newValue(slider.value.toFixed(2));

    ULabel.Default
    {
        color: Colors.uGrey
        text: Math.round(slider.value) + "%"

        width: textWidth
        horizontalAlignment: Text.AlignHCenter

        font.bold: true
        font.pointSize: textSize
        anchors.right: parent.left

        anchors.verticalCenter: parent.verticalCenter
    }
}
