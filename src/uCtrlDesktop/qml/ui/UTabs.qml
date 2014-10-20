import QtQuick 2.0

Rectangle {

    id: container

    property variant items: null
    property string selectedValue: ""

    property string backgroundColor: "#0D9B0D"
    property string selectedColor: "#0D740D"
    property string hoverColor: "#0DBE0D"
    property string iconColor: "white"

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

                iconColor: iconColor
                color: getColor()

                radius: 2

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
