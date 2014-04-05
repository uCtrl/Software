import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    id: container

    property var deviceModel: devicesList.model.getDeviceAt(index)

    width: parent.width
    height: 60

    color: _colors.uTransparent

    Rectangle {
        id: iconFrame

        anchors.left: parent.left
        anchors.leftMargin: 15

        anchors.verticalCenter: parent.verticalCenter

        width: 40; height: 40
        radius: 5

        color: _colors.uGreen

        // @TODO : Replace with proper icon when ready.
        ULabel.Default {
            id: iconLabel

            text: deviceModel.type

            anchors.centerIn: iconFrame

            Component.onCompleted: {
                font.pixelSize = 32
                font.bold = true
                color = _colors.uWhite
            }
        }
    }

    ULabel.Default {
        anchors.left: iconFrame.right
        anchors.leftMargin: 25

        anchors.verticalCenter: parent.verticalCenter

        text: deviceModel.name

        Component.onCompleted: {
            font.pixelSize = 24
            font.bold = true
        }
    }

    UI.UFontAwesome {
        id: chevronRight

        anchors.right: container.right
        anchors.rightMargin: 20

        anchors.verticalCenter: container.verticalCenter

        iconId: "ChevronRight"
        iconSize: 32
        iconColor: _colors.uLightGrey
    }

    Rectangle {
        property int marginSize: 3

        id: bottomLine

        width: parent.width - (marginSize *2)
        height: 1

        anchors.left: parent.left
        anchors.leftMargin: marginSize

        anchors.top: parent.bottom

        color: _colors.uLightGrey
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true
        onHoveredChanged: color = (containsMouse ? _colors.uUltraLightGrey : _colors.uTransparent)

        onClicked: {
            main.swap(_paths.uConfig, "", deviceModel)
        }
    }
}
