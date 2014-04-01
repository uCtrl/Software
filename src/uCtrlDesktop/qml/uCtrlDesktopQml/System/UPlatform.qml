import QtQuick 2.0

Rectangle {
    id: container

    //property var platformModel: platformsList.model.getPlatformAt(index)

    width: parent.width
    height: 60

    color: _colors.uDarkRed

    Component.onCompleted: {
        console.log(platformsList.model.getPlatformAt(0))
    }
}
