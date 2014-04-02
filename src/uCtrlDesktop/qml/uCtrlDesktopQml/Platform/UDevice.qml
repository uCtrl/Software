import QtQuick 2.0
import "../UI" as UI

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

        width: 20; height: 20
        radius: 5

        color: _colors.uGreen

        // @TODO : Replace with proper icon when ready.
        UI.ULabel {
            id: iconLabel

            text: deviceModel.type

            anchors.centerIn: iconFrame

            Component.onCompleted: {
                font.pixelSize = 16
                color = _colors.uWhite
            }
        }
    }

    UI.ULabel {
        anchors.left: iconFrame.right
        anchors.leftMargin: 25

        anchors.verticalCenter: parent.verticalCenter

        text: deviceModel.name

        headerStyle: 0
        Component.onCompleted: {
            font.pixelSize = 24
            font.bold = true
        }
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
