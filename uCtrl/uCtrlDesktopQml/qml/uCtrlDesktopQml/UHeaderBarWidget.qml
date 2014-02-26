import QtQuick 2.0

Rectangle {
    width: parent.width
    height: 80
    anchors.top: parent.top

    Rectangle {
        id: navigationBar
        width: parent.width
        height: parent.height * 0.5
        anchors.top: parent.top
        color: "#14892C"

        UImageWidget {
            //Back button
            anchors.left: parent.left
            anchors.top: parent.top
            source: "qrc:///Resources/Images/Back.png"
        }

        UImageWidget {
            //Home button
            anchors.right: parent.right
            anchors.top: parent.top
            source: "qrc:///Resources/Images/uCtrl-Icon.png"
        }
    }

    Rectangle {
        id: titleBar
        width: parent.width
        height: parent.height * 0.5
        anchors.top: navigationBar.bottom
        color: "#14892C"

        UTitleLabelWidget {
            anchors.centerIn: parent
            labelText: "My title!"
        }
    }
}
