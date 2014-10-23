import QtQuick 2.0

import "../../ui/UColors.js" as Colors
Rectangle {
    id: container

    property variant periods: [
        { value: "today",     displayedValue: "Today", iconId: ""},
        { value: "week",   displayedValue: "This week", iconId: ""},
        { value: "month",   displayedValue: "This month", iconId: ""},
   ]

    color: Colors.uTransparent

    Temperature {
        id: temperature

        property var item: main.activeDevice
        property variant periods: container.periods

        anchors.fill: parent

        color: container.color

        function getType() {
            return "Humidity (sensor)"
        }

        function getModel() {
            return "La Crosse Humidity WS2355"
        }
    }
}
