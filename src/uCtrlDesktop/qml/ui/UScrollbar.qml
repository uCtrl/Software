import QtQuick 2.0

Item {
    id: scrollbar;

    property Flickable flk : undefined
    property int basicWidth: 10
    property int expandedWidth: 20
    property alias color : scrl.color
    property alias radius : scrl.radius

    width: basicWidth
    anchors.left: flk.right;
    anchors.leftMargin: 2;
    anchors.top: flk.top
    anchors.bottom: flk.bottom
    z:1

    Binding {
        target: scrollbar
        property: "width"
        value: expandedWidth
        when: ma.drag.active || ma.containsMouse
    }
    Behavior on width {NumberAnimation {duration: 150}}

    Rectangle {
        id: scrl
        clip: true
        anchors.left: parent.left
        anchors.right: parent.right
        height: flk.visibleArea.heightRatio * flk.height
        visible: flk.visibleArea.heightRatio < 1.0
        radius: 10
        color: "gray"

        opacity: ma.pressed ? 1 : ma.containsMouse ? 0.65 : 0.4
        Behavior on opacity {NumberAnimation{duration: 150}}

        Binding {
            target: scrl
            property: "y"
            value: (ma.drag.maximumY * flk.contentY) / (flk.contentHeight * (1 - flk.visibleArea.heightRatio))
            when: !ma.drag.active
        }

        Binding {
            target: flk
            property: "contentY"
            value: ((flk.contentHeight * (1 - flk.visibleArea.heightRatio)) * scrl.y) / ma.drag.maximumY
            when: ma.drag.active
        }

        MouseArea {
            id: ma
            anchors.fill: parent
            hoverEnabled: true
            drag.target: parent
            drag.axis: Drag.YAxis
            drag.minimumY: 0
            drag.maximumY: flk.height - scrl.height
            preventStealing: true
        }
    }
}
