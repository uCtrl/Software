import QtQuick 2.0

Rectangle {

    color: "white"

    property variant model: null

    ListView {
        id: devices
        anchors.fill: parent
        model: parent.model
        delegate: Column {
            width: parent.width
            DeviceListItem {

                item: model

                MouseArea {
                    anchors.fill: parent

                    onClicked: {
                        console.log(id);
                    }
                }
            }
        }
    }

    /*
        delegate: Column {
            width: parent.width
            height: 20

            Text {
                text: id + " | " + type + " | " + description + " | " + isEnabled + " | " + isTriggerValue + " | " + maxValue + " | " + minValue + " | " + name + " | " + precision + " | " + status + " | " + unitLabel
                wrapMode: Text.WordWrap
                MouseArea {
                    anchors.fill: parent
                    height: parent.height; width: parent.width;
                    onClicked: {
                        console.log(id);
                    }
                }
            }
        }
   */
}
