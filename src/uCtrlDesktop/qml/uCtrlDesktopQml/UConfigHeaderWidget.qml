import QtQuick 2.0

Rectangle {
    property string img: "DEFAULT URL OF AN IMG"
    property string title: "DEFAULT TITLE"
    property string subtitle: "DEFAULT SUBTITLE"

    width: parent.width
    height: 100
    color: "#14892C"
    border.width: 2
    border.color: "black"
    Rectangle {
        id: headerLogo
        width: 100
        height: 100
        color: "transparent"


        Rectangle {
            width: 80
            height: width
            color: "white"
            border.width: 2
            anchors.centerIn: parent
            radius: width * 0.5

            Image {
                anchors.centerIn: parent
                height: 50
                width: 50
                source: img
            }
        }
    }

    Rectangle {
        id: titleContainer
        anchors.left: headerLogo.right
        anchors.right: parent.right
        height: parent.height * 0.5
        color: "transparent"

        UTitleLabelWidget {
            id: titleLabel
            anchors.bottom: parent.bottom
            labelText: title
        }

    }

    Rectangle {
        id: subtitleContainer
        anchors.top: titleContainer.bottom
        anchors.left: headerLogo.right
        anchors.right: parent.right
        height: parent.height * 0.5
        color: "transparent"

        USubtitleLabelWidget {
            id: subtitleLabel
            anchors.top: parent.top
            labelText: subtitle
        }
    }
}
