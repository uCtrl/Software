import QtQuick 2.0

Rectangle {
    id: container
    property var model: null

    Sensor {
        model: container.model
        anchors.fill: parent
    }
}
