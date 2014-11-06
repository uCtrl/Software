import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../ui/UColors.js" as Colors

Rectangle {
    id: alert

    border.width: 1
    radius: 2
    z:3

    anchors.topMargin: 10
    anchors.horizontalCenter: parent.horizontalCenter
    width: getWidth();
    height: getHeight();

    opacity: 0

    function show(type, text) {
        label.text = text
        alert.state = "visible"

        switch(type) {
            case 0:
                label.color = Colors.sucessText;
                alert.color = Colors.sucessBack;
                alert.border.color = Colors.sucessBorder;
                break;
            case 2:
                label.color = Colors.warningText;
                alert.color = Colors.warningBack;
                alert.border.color = Colors.warningBorder;
                break;
            case 3:
                label.color = Colors.errorText;
                alert.color = Colors.errorBack;
                alert.border.color = Colors.errorBorder;
                break;
            default:
                label.color = Colors.infoText;
                alert.color = Colors.infoBack;
                alert.border.color = Colors.infoBorder;
                break;
        }

        timer.start()
    }

    function success(text) { show(0, text); }
    function info(text) { show(1, text); }
    function warning(text) { show(2, text); }
    function error(text) { show(3, text); }

    states: State {
        name: "visible"
        PropertyChanges { target: alert; opacity: 1 }
        PropertyChanges { target: alert; y: 100 }
    }

    transitions: [
        Transition { from: ""; PropertyAnimation { properties: "opacity,y"; duration: 600 } },
        Transition { from: "visible"; PropertyAnimation { properties: "opacity,y"; duration: 500 } }
    ]

    Timer {
        id: timer
        interval: 6000

        onTriggered: alert.state = ""
    }

    ULabel.Default {
        id: label
        font.pointSize: 15
        anchors.centerIn: parent
        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter
        smooth: true
    }

    function getWidth() {
        return label.width * 1.5;
    }

    function getHeight() {
        return label.height * 1.5;
    }
}
