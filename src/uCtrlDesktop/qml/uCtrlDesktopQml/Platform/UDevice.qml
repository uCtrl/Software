import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property var deviceModel: devicesList.model.getDeviceAt(index)

    width: parent.width
    height: 50

    color: _colors.uTransparent

    Rectangle {
        id: iconFrame

        anchors.left: parent.left
        anchors.leftMargin: 10

        anchors.verticalCenter: parent.verticalCenter

        width: 32
        height: 32
        radius: radiusSize

        color: _colors.uGreen

        // @TODO : Replace with proper icon when ready.
        UI.UFontAwesome {
            id: iconLabel

            anchors.centerIn: iconFrame

            iconId: "Bolt"
            iconSize: 24
            iconColor: _colors.uWhite
        }
    }

    ULabel.Default {
        anchors.left: iconFrame.right
        anchors.leftMargin: 10

        anchors.verticalCenter: parent.verticalCenter
        verticalAlignment: Text.AlignVCenter

        text: deviceModel.name

        Component.onCompleted: {
            font.pixelSize = 18
            font.bold = true
        }
    }

    UI.UFontAwesome {
        id: chevronRight

        anchors.right: container.right
        anchors.rightMargin: 15

        anchors.verticalCenter: container.verticalCenter

        iconId: "ChevronRight"
        iconSize: 22
        iconColor: _colors.uMediumLightGrey
    }

    Rectangle {
        id: bottomLine

        width: parent.width
        height: 1

        anchors.left: parent.left
        anchors.top: parent.bottom

        color: _colors.uLightGrey
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor

        hoverEnabled: true
        onHoveredChanged: color = (containsMouse ? _colors.uLightGrey : _colors.uTransparent)

        onClicked: {
            main.swap(_paths.uConfig, deviceModel.name, deviceModel)
        }
    }

    Rectangle {
        id: informationRight
        anchors.right: chevronRight.left
        anchors.rightMargin: 25

        height: parent.height
        width: 40

        anchors.verticalCenter: container.verticalCenter

        color: _colors.uTransparent
    }
}
