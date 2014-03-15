import QtQuick 2.0

Rectangle {
    // Default properties
    property color backgroundColor: "white"
    property variant model: null
    property bool requiredModel: false
    property string name: "unknown"

    // Default dimensions, anchoring and coloring
    width: parent.width
    height: parent.height

    anchors.top: parent.top
    anchors.topMargin: 40
    anchors.left: parent.left

    color: backgroundColor

    // Responsive signals
    signal move(int x, int y)
    onMove: {
        for (var i=0; i<children.length;i++) {
            children[i].x += x
            children[i].y += y
        }
    }

    signal bind(variant newModel)
    onBind: {
        if (requiredModel) {
            model = newModel
            refresh(model)
        }
    }

    // FOLLOWING FUNCTIONS MAY BE OVERRIDEN BY FRAME LEAF
    function refresh() {
    }
}
