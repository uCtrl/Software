import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle {
    property string title: "DEFAULT TITLE"
    property string value: "DEFAULT VALUE"
    property bool isEditable: false

    width: parent.width
    height: 40
    color: _colors.uLightGrey

    Rectangle {
        id: infoPaddinLeft
        width: 10
        height: parent.height
        anchors.left: parent.left
        color: _colors.uTransparent
    }

    ULabel.Default {
        id: titleLabel
        width:150

        anchors.verticalCenter: parent.verticalCenter
        anchors.left: infoPaddinLeft.right
        text: title
    }

    Loader {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: titleLabel.right
        anchors.leftMargin: 20
        sourceComponent: isEditable ? deviceInfoEditComponent : deviceInfoFixedComponent
    }

    Component {
        id: deviceInfoEditComponent
        UDeviceInfoEdit {
            text: value
        }
    }

    Component {
        id: deviceInfoFixedComponent
        UDeviceInfoFixed {
            text: value
        }
    }
}
