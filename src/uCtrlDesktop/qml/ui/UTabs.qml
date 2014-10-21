import QtQuick 2.0

import "UColors.js" as Colors

Rectangle {

    id: container

    property variant items: null
    property string selectedValue: ""

    property string backgroundColor: Colors.get("uGreen")
    property string selectedColor: Colors.get("uDarkGreen")
    property string hoverColor: Colors.get("uMediumLightGreen")
    property string iconColor: Colors.get("uWhite")

    property bool showText: false

    color: backgroundColor

    radius: 2

    Row {

        anchors.fill: parent

        Repeater {
            model: items

            UTabItem {
                iconId: modelData.icon

                height: container.height;
                width: (container.width / items.length)

                iconColor: container.iconColor
                color: getColor()

                radius: 2

                linkText: container.showText ? modelData.text : ""
                showText: container.showText

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: selectedValue = modelData.value
                }

                function getColor() {
                    if (selectedValue === modelData.value) return selectedColor
                    else return mouseArea.containsMouse ? hoverColor : backgroundColor
                }
            }
        }
    }
}
