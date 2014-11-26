import QtQuick 2.0

import "UColors.js" as Colors
import "../label" as ULabel

Rectangle {
    id: colorPickerContainer
    width: 300
    height: 165

    property double hue: 0
    property double saturation: 0
    property double value: 0

    property double r: getChannelStr(pickerColor, 0)
    property double g: getChannelStr(pickerColor, 1)
    property double b: getChannelStr(pickerColor, 2)

    property var saturatedPickerColor: hsb(hue, 1, 1)
    property var pickerColor: hsb(hue, saturation, value)
    property var pickerColorString: fullColorString(pickerColor)
    onPickerColorStringChanged: colorStringTextbox.text = pickerColorString

    color: Colors.uDarkGrey

    Rectangle
    {
        anchors.fill: parent
        anchors.margins: 1
        clip: true

        Rectangle
        {
            id: colorPicker
            width: parent.height
            height: parent.height

            color: Colors.uTransparent

            Rectangle {
                anchors.fill: parent;
                rotation: -90
                gradient: Gradient {
                    GradientStop {
                        position: 0.0; color: "#FFFFFFFF"
                    }
                    GradientStop {
                        position: 1.0; color: saturatedPickerColor
                    }
                }
            }
            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop {
                        position: 1.0; color: "#FF000000"
                    }
                    GradientStop {
                        position: 0.0; color: "#00000000"
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                function handleMouse(mouse) {
                    if (mouse.buttons & Qt.LeftButton) {
                        colorPickerContainer.saturation = Math.max(0, Math.min(width,  mouse.x)) / width
                        colorPickerContainer.value = 1 - Math.max(0, Math.min(height, mouse.y)) / height
                    }
                }
                onPositionChanged: handleMouse(mouse)
                onPressed: handleMouse(mouse)
            }

            Rectangle
            {
                id: colorPickerSelector
                width: 20
                height: 20

                x: colorPickerContainer.saturation * colorPicker.width - width / 2
                y: (1 - colorPickerContainer.value) * colorPicker.height - height / 2

                color: Colors.uTransparent

                Rectangle
                {
                    width: parent.width
                    height: parent.height
                    radius: parent.width / 2

                    color: Colors.uTransparent
                    border.color: Colors.uWhite
                    border.width: 4

                    anchors.centerIn: parent
                }

                Rectangle
                {
                    anchors.fill: parent
                    radius: parent.width / 2

                    color: Colors.uTransparent
                    border.color: Colors.uBlack
                    border.width: 2
                }
            }
        }

        Rectangle
        {
            id: huePicker
            width: 10
            height: parent.height

            anchors.left: colorPicker.right

            color: Colors.uDarkGrey

            z: 2

            Rectangle {
                width: parent.width - 2
                height: parent.height
                anchors.centerIn: parent

                gradient: Gradient {
                    GradientStop { position: 1.0;  color: "#FF0000" }
                    GradientStop { position: 0.85; color: "#FFFF00" }
                    GradientStop { position: 0.76; color: "#00FF00" }
                    GradientStop { position: 0.5;  color: "#00FFFF" }
                    GradientStop { position: 0.33; color: "#0000FF" }
                    GradientStop { position: 0.16; color: "#FF00FF" }
                    GradientStop { position: 0.0;  color: "#FF0000" }
                }
            }

            MouseArea {
                anchors.fill: parent
                function handleMouse(mouse) {
                    if (mouse.buttons & Qt.LeftButton) {
                        colorPickerContainer.hue = 1 - Math.max(0, Math.min(height, mouse.y)) / height
                    }
                }
                onPositionChanged: handleMouse(mouse)
                onPressed: handleMouse(mouse)
            }

            Rectangle
            {
                id: huePickerSelector
                width: parent.width + 4
                height: 8
                color: Colors.uTransparent

                y: (1 - colorPickerContainer.hue) * huePicker.height - height / 2

                anchors.horizontalCenter: parent.horizontalCenter

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
            id: colorDescription

            z: 1

            anchors.left: huePicker.right
            anchors.right: parent.right
            height: parent.height

            color: Colors.uGrey

            Rectangle
            {
                width: parent.width - 4
                height: parent.height - 4
                anchors.centerIn: parent

                color: Colors.uTransparent

                Column
                {
                    anchors.fill: parent
                    spacing: 2

                    Rectangle
                    {
                        width: parent.width
                        height: 30

                        border.color: Colors.uDarkGrey
                        border.width: 1

                        color: colorPickerContainer.pickerColor
                    }

                    UTextbox
                    {
                        id: colorStringTextbox
                        width: parent.width
                        height: 20

                        pointSize: 8

                        text: colorPickerContainer.pickerColorString
                        Keys.onReturnPressed: hsbFromRgb(text)
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: 15
                        color: Colors.uTransparent

                        ULabel.Default
                        {
                            text: "H:"

                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.14
                            anchors.verticalCenter: parent.verticalCenter

                            font.pointSize: 8
                            font.italic: true
                            color: Colors.uDarkGrey
                        }

                        Rectangle
                        {
                            anchors.right: parent.right
                            width: parent.width * 0.70
                            height: parent.height

                            color: Colors.uTransparent

                            Rectangle
                            {
                                width: parent.width - 1
                                height: parent.height - 1
                                border.color: Colors.uBlack
                                border.width: 1
                                x: 1
                                y: 1

                                color: Colors.uTransparent
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height
                                border.color: Colors.uDarkGrey
                                border.width: 1

                                color: Colors.uTransparent
                            }

                            ULabel.Default
                            {
                                anchors.centerIn: parent
                                color: Colors.uDarkGrey
                                text: colorPickerContainer.hue.toFixed(2)
                                font.pointSize: 8
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: 15
                        color: Colors.uTransparent

                        ULabel.Default
                        {
                            text: "S:"

                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.14
                            anchors.verticalCenter: parent.verticalCenter

                            font.pointSize: 8
                            font.italic: true
                            color: Colors.uDarkGrey
                        }

                        Rectangle
                        {
                            anchors.right: parent.right
                            width: parent.width * 0.70
                            height: parent.height

                            color: Colors.uTransparent

                            Rectangle
                            {
                                width: parent.width - 1
                                height: parent.height - 1
                                border.color: Colors.uBlack
                                border.width: 1
                                x: 1
                                y: 1

                                color: Colors.uTransparent
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height
                                border.color: Colors.uDarkGrey
                                border.width: 1

                                color: Colors.uTransparent
                            }

                            ULabel.Default
                            {
                                anchors.centerIn: parent
                                color: Colors.uDarkGrey
                                text: colorPickerContainer.saturation.toFixed(2)
                                font.pointSize: 8
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: 15
                        color: Colors.uTransparent

                        ULabel.Default
                        {
                            text: "V:"

                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.14
                            anchors.verticalCenter: parent.verticalCenter

                            font.pointSize: 8
                            font.italic: true
                            color: Colors.uDarkGrey
                        }

                        Rectangle
                        {
                            anchors.right: parent.right
                            width: parent.width * 0.70
                            height: parent.height

                            color: Colors.uTransparent

                            Rectangle
                            {
                                width: parent.width - 1
                                height: parent.height - 1
                                border.color: Colors.uBlack
                                border.width: 1
                                x: 1
                                y: 1

                                color: Colors.uTransparent
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height
                                border.color: Colors.uDarkGrey
                                border.width: 1

                                color: Colors.uTransparent
                            }

                            ULabel.Default
                            {
                                anchors.centerIn: parent
                                color: Colors.uDarkGrey
                                text: colorPickerContainer.value.toFixed(2)
                                font.pointSize: 8
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: 3
                        color: Colors.uTransparent
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: 15
                        color: Colors.uTransparent

                        ULabel.Default
                        {
                            text: "R:"

                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.14
                            anchors.verticalCenter: parent.verticalCenter

                            font.pointSize: 8
                            font.italic: true
                            color: Colors.uDarkGrey
                        }

                        Rectangle
                        {
                            anchors.right: parent.right
                            width: parent.width * 0.70
                            height: parent.height

                            color: Colors.uTransparent

                            Rectangle
                            {
                                width: parent.width - 1
                                height: parent.height - 1
                                border.color: Colors.uBlack
                                border.width: 1
                                x: 1
                                y: 1

                                color: Colors.uTransparent
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height
                                border.color: Colors.uDarkGrey
                                border.width: 1

                                color: Colors.uTransparent
                            }

                            ULabel.Default
                            {
                                anchors.centerIn: parent
                                color: Colors.uDarkGrey
                                text: colorPickerContainer.b
                                font.pointSize: 8
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: 15
                        color: Colors.uTransparent

                        ULabel.Default
                        {
                            text: "G:"

                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.14
                            anchors.verticalCenter: parent.verticalCenter

                            font.pointSize: 8
                            font.italic: true
                            color: Colors.uDarkGrey
                        }

                        Rectangle
                        {
                            anchors.right: parent.right
                            width: parent.width * 0.70
                            height: parent.height

                            color: Colors.uTransparent

                            Rectangle
                            {
                                width: parent.width - 1
                                height: parent.height - 1
                                border.color: Colors.uBlack
                                border.width: 1
                                x: 1
                                y: 1

                                color: Colors.uTransparent
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height
                                border.color: Colors.uDarkGrey
                                border.width: 1

                                color: Colors.uTransparent
                            }

                            ULabel.Default
                            {
                                anchors.centerIn: parent
                                color: Colors.uDarkGrey
                                text: colorPickerContainer.g
                                font.pointSize: 8
                            }
                        }
                    }

                    Rectangle
                    {
                        width: parent.width
                        height: 15
                        color: Colors.uTransparent

                        ULabel.Default
                        {
                            text: "B:"

                            anchors.left: parent.left
                            anchors.leftMargin: parent.width * 0.14
                            anchors.verticalCenter: parent.verticalCenter

                            font.pointSize: 8
                            font.italic: true
                            color: Colors.uDarkGrey
                        }

                        Rectangle
                        {
                            anchors.right: parent.right
                            width: parent.width * 0.70
                            height: parent.height

                            color: Colors.uTransparent

                            Rectangle
                            {
                                width: parent.width - 1
                                height: parent.height - 1
                                border.color: Colors.uBlack
                                border.width: 1
                                x: 1
                                y: 1

                                color: Colors.uTransparent
                            }

                            Rectangle
                            {
                                width: parent.width
                                height: parent.height
                                border.color: Colors.uDarkGrey
                                border.width: 1

                                color: Colors.uTransparent
                            }

                            ULabel.Default
                            {
                                anchors.centerIn: parent
                                color: Colors.uDarkGrey
                                text: colorPickerContainer.b
                                font.pointSize: 8
                            }
                        }
                    }
                }
            }
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
        return "#" + (clr.toString().substr(1, 6)).toUpperCase();
    }

    //  extracts integer color channel value [0..255] from color value
    function getChannelStr(clr, channelIdx) {
        return parseInt(clr.toString().substr(channelIdx*2 + 1, 2), 16);
    }
}
