import QtQuick 2.0

Rectangle {
    property string img: "DEFAULT URL OF AN IMG"
    property string title: "DEFAULT TITLE"
    property string subtitle: "DEFAULT SUBTITLE"

    width: parent.width
    height: 70
    color: "#14892C"

    Rectangle {
        id: headerLogo
        width: 70
        height: parent.height
        color: "transparent"

        Image {
            anchors.centerIn: parent
            height: 50
            width: 50
            source: img
        }
    }

    Rectangle {
        anchors.left: headerLogo.right
        height: parent.height
        color: "transparent"

        UTitleLabelWidget {
            id: titleLabel
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            labelText: title
        }
        USubtitleLabelWidget {
            id: subtitleLabel
            anchors.left: parent.left
            anchors.top: titleLabel.bottom
            labelText: subtitle
        }
    }
}
