import QtQuick 2.0

import "../../ui/UColors.js" as Colors

Rectangle {
    property int rowHeight: 38
    property bool expanded: true

    height: expanded ? rowHeight : 0
    visible: expanded
    color: Colors.uTransparent
}
