import QtQuick 2.0
import "../ui/UColors.js" as Colors

import "../ui" as UI

Rectangle {

    id: container
    clip: true

    property variant model: null
    property string filterText: ""

    /*Rectangle {
        id: filters

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: parent.marginSize

        height: 35
        width: (parent.width/2) - parent.marginSize

        color: Colors.uTransparent

        z: 2

        UI.UTextbox {
            id: searchBox

            anchors.left: filters.left
            anchors.leftMargin: 0

            anchors.right: filters.right

            anchors.verticalCenter: filters.verticalCenter

            height: filters.height; width: 2 * (filters.width / 3);

            state: "ENABLED"

            opacity: 0.75

            placeholderText: "Search"

            iconId: "search"
            iconSize: 13

            onTextChanged: {
                filterText = searchBox.text
            }
        }
    }*/

    Rectangle {
        id: filters

        color: Colors.uTransparent

        anchors.top: container.top
        anchors.left: container.left
        anchors.right: container.right

        height: 35

        UI.UTextbox {
            id: searchBox

            anchors.left: filters.left
            anchors.right: filters.right

            anchors.verticalCenter: filters.verticalCenter
            height: filters.height; width: 2 * (filters.width / 3);

            state: "ENABLED"

            opacity: 0.75

            placeholderText: "Search"

            iconId: "search"
            iconSize: 13

            onTextChanged: {
                filterText = searchBox.text
            }
        }
    }

    ListView {
        id: devicesList

        anchors.top: filters.bottom
        anchors.bottom: container.bottom
        anchors.left: container.left
        anchors.right: container.right

        model: parent.model

        property variant currentItem: null

        delegate: Column {
            id: column

            width: parent.width
            DeviceListItem {

                id: listItem

                item: model

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        main.devicesList = devicesList.model
                        main.activeDevice = model
                        main.currentPage = "device/Device"
                        main.resetBreadcrumbDevices()
                        main.addToBreadcrumbDevices("device/Device", model.name)
                    }
                }

                visible: (filterValue(item, filterText))
            }

            function filterValue(source, filter) {
                return (filter === ""
                        || source.name.toLowerCase().indexOf(filter.toLowerCase()) !== -1
                        || source.description.toLowerCase().indexOf(filter.toLowerCase()) !== -1)
            }
        }
    }
}
