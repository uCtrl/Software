import QtQuick 2.0
import QtQuick.Controls 1.0

import "../UI" as UI

UI.UFrame {
    contentItem: Rectangle {
        anchors.left: parent.left
        anchors.leftMargin: frameMarginSize

        anchors.top: parent.top
        anchors.topMargin: frameMarginSize

        width: (scrollView.width - (frameMarginSize *2))
        height: (scrollView.height - (frameMarginSize *2))

        color: _colors.uTransparent
    }
}
