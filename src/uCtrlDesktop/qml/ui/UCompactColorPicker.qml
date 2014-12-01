import QtQuick 2.0

import "UColors.js" as Colors
import "../label" as ULabel

Rectangle {
    id: colorPickerContainer
    width: 130
    height: 30

    property double hue: 0
    property double saturation: 1
    property double value: 1

    property double r: getChannelStr(pickerColor, 0)
    property double g: getChannelStr(pickerColor, 1)
    property double b: getChannelStr(pickerColor, 2)

    property var saturatedPickerColor: hsb(hue, 1, 1)
    property var pickerColor: hsb(hue, saturation, value)
    property var pickerString: fullColorString(pickerColor)
    property string pickerColorString: "#" + pickerString
    onPickerColorStringChanged: {
        colorDisplayer.color = pickerColorString
    }

    color: Colors.uTransparent

    Rectangle
    {
        anchors.fill: parent
        anchors.margins: 1

        color: Colors.uTransparent

        Rectangle
        {
            id: huePicker
            width: parent.width - (parent.height + 5)
            height: parent.height

            color: Colors.uTransparent

            z: 2

            Rectangle
            {
                width: parent.width
                height: parent.height

                color: Colors.uTransparent

                Rectangle {
                    width: parent.height
                    height: parent.width
                    x: parent.width

                    gradient: Gradient {
                        GradientStop { position: 1.0;  color: "#FF0000" }
                        GradientStop { position: 0.85; color: "#FFFF00" }
                        GradientStop { position: 0.76; color: "#00FF00" }
                        GradientStop { position: 0.5;  color: "#00FFFF" }
                        GradientStop { position: 0.33; color: "#0000FF" }
                        GradientStop { position: 0.16; color: "#FF00FF" }
                        GradientStop { position: 0.0;  color: "#FF0000" }
                    }

                    transform: Rotation
                    {
                        angle: 90
                    }
                }

            }

            MouseArea {
                anchors.fill: parent
                function handleMouse(mouse) {
                    if (mouse.buttons & Qt.LeftButton) {
                        colorPickerContainer.hue = 1 - Math.max(0, Math.min(width, mouse.x)) / width
                    }
                }
                onPositionChanged: handleMouse(mouse)
                onPressed: handleMouse(mouse)
            }

            Rectangle
            {
                id: huePickerSelector
                width: 8
                height: parent.height + 4
                color: Colors.uTransparent

                x: (1 - colorPickerContainer.hue) * huePicker.width - width / 2

                anchors.verticalCenter: parent.verticalCenter

                Rectangle
                {
                    width: parent.width
                    height: parent.height
                    radius: 3

                    color: Colors.uTransparent
                    border.color: Colors.uWhite
                    border.width: 2

                    anchors.centerIn: parent
                }

                Rectangle
                {
                    anchors.fill: parent
                    radius: 3

                    color: Colors.uTransparent
                    border.color: Colors.uBlack
                    border.width: 1
                }
            }
        }

        Rectangle
        {
            id: colorDisplayer

            width: parent.height
            height: parent.height

            radius: 5
            color: "red"

            anchors.right: parent.right
        }
    }

    function hsbFromRgb(clr)
    {
        if(clr.length < 7)
            return

        var rr, gg, bb,
                r = getChannelStr(clr, 0) / 255,
                g = getChannelStr(clr, 1) / 255,
                b = getChannelStr(clr, 2) / 255,
                h, s,
                v = Math.max(r, g, b),
                diff = v - Math.min(r, g, b),
                diffc = function(c){
                    return (v - c) / 6 / diff + 1 / 2;
                };

            if (diff == 0) {
                h = s = 0;
            } else {
                s = diff / v;
                rr = diffc(r);
                gg = diffc(g);
                bb = diffc(b);

                if (r === v) {
                    h = bb - gg;
                }else if (g === v) {
                    h = (1 / 3) + rr - bb;
                }else if (b === v) {
                    h = (2 / 3) + gg - rr;
                }
                if (h < 0) {
                    h += 1;
                }else if (h > 1) {
                    h -= 1;
                }
            }

            colorPickerContainer.hue = h
            colorPickerContainer.saturation = s
            colorPickerContainer.value = v
    }

    function hsb(h, s, b) {
        var a = 1
        var lightness = (2 - s)*b;
        var satHSL = s*b/((lightness <= 1) ? lightness : 2 - lightness);
        lightness /= 2;
        return Qt.hsla(h, satHSL, lightness, a);
    }

    //  creates a full color string from color value and alpha[0..1], e.g. "#00FF00"
    function fullColorString(clr) {
        return (clr.toString().substr(1, 6)).toUpperCase();
    }

    //  extracts integer color channel value [0..255] from color value
    function getChannelStr(clr, channelIdx) {
        return parseInt(clr.toString().substr(channelIdx*2 + 1, 2), 16);
    }
}
