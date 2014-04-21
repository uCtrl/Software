import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel
import "../Platform" as Platform

UI.UFrame {
    id: systemFrame

    property var system: null
    requiredModel: true

    function refresh(newSystem) {
        system = newSystem
    }

    signal notify;
    onNotify: {
        refresh(system)
    }

    contentItem: Rectangle {
        id: systemContainer

        z: 2

        property var activePlatform: null
        onActivePlatformChanged: {
            platformInfo.isEditing = false
        }

        property int constSize: 16
        property int separation: 10

        anchors.left: parent.left
        anchors.leftMargin: constSize

        anchors.top: parent.top
        anchors.topMargin: constSize

        width: (scrollView.width - (constSize *2))
        height: (scrollView.height - (constSize *2))

        color: _colors.uTransparent

        function loadPlatforms() {
            var otherPlatforms = true
            var index = 0;

            while(otherPlatforms) {
                var data = mySystem.getPlatformAt(index);

                if (data !== null) {
                    var platform = {
                        "name": data.name,
                        "room": data.room,
                        "reference": data,
                        "alphabet": data.name[0],
                        "type": data.type
                    }

                   systemPlatforms.append(platform);

                    index++;
                } else {
                    otherPlatforms = false
                }
            }
        }

        ListModel { id: systemPlatforms }

        Rectangle {
            id: header
            z:1

            property int separation: 5

            anchors.top: systemContainer.top
            anchors.left: systemContainer.left
            anchors.right: systemContainer.right

            height: 40

            color: _colors.uTransparent

            UI.UTextbox {
                id: searchBox

                anchors.left: header.left
                anchors.leftMargin: 0
                anchors.verticalCenter: header.verticalCenter

                width: platformListContainer.width - (filterCombo.width + header.separation)
                height: filterCombo.height

                state: "ENABLED"

                opacity: 0.5

                placeholderText: "Search"

                iconId: "Search"
                iconSize: 16

                onTextChanged: {
                    platformListContainer.setFilter(searchBox.text)
                }
            }
        }

        UPlatformsList {
            id: platformListContainer

            anchors.top: header.bottom
            anchors.topMargin: 5

            anchors.left: systemContainer.left

            width: ((systemContainer.width/2) - systemContainer.separation)
            height: (systemContainer.height - header.height - 5)

            section: filterCombo.selectedItem.value
        }

        Platform.UPlatform {
            id: platformInfo

            visible: (systemContainer.activePlatform !== null)

            anchors.top: platformListContainer.top
            anchors.right: systemContainer.right

            width: ((systemContainer.width/2) - systemContainer.separation)
            height: (systemContainer.height - header.height - 5)

            radius: 5

            color: _colors.uWhite
        }

        Rectangle {
            id: pleaseSelectPlatform

            visible: (systemContainer.activePlatform === null)

            anchors.top: platformListContainer.top
            anchors.right: systemContainer.right

            width: ((systemContainer.width/2) - systemContainer.separation)
            height: (systemContainer.height - header.height)

            radius: 5

            color: _colors.uTransparent

            ULabel.Default {
                id: regularText

                text: "Please select a platform"

                anchors.centerIn: pleaseSelectPlatform

                font.pointSize: 28
                font.bold: true
                color: _colors.uGrey
                }
            }

        UI.UComboBox {
            id: filterCombo

            anchors.left: header.left
            anchors.leftMargin: (searchBox.width + header.separation)

            anchors.verticalCenter: header.verticalCenter

            width: 200; height: 30

            itemListModel: [
                                { value: "room",     displayedValue: "Location",     iconId: "MapMarker"},
                            //  { value: "update",     displayedValue: "Last Updated", iconId: "Calendar"},     // Not in model yet
                            //  { value: "status",     displayedValue: "Status",       iconId: "Magnet"},       // Not in model yet
                            //  { value: "type",     displayedValue: "Device type",  iconId: "Magnet"}          // Not in platform model yet, still exists in device.
                                { value: "alphabet", displayedValue: "Name",         iconId: "Font"}
                            ]

            onSelectedItemChanged:{
                platformListContainer.section = selectedItem.value
            }

            Component.onCompleted: {
                selectItem(0)
            }
        }

        Component.onCompleted: { loadPlatforms() }
    }
}
