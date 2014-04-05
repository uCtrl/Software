import QtQuick 2.0

import "../UI/UTabs" as Tab

Rectangle {
    id: tabs

    property var icons: []
    property var texts: []
    property var selectedTab
    property int iconSize : 16
    property int defaultSelected: 0
    width: parent.width
    height: parent.height

    color: _colors.uTransparent

    ListView {
        id: list
        model: icons
        anchors.fill: parent
        delegate: tab
        orientation: ListView.Horizontal
        interactive: false
    }
    Component {
        id: tab
        Tab.UTabItem {
            width: tabs.width / icons.length
            isFirst: (index == 0)
            isLast: (index == icons.length - 1)
            iconId: icons[index]
            text: texts[index]
            iconSize: tabs.iconSize
            onClicked: {
                if(selectedTab !== undefined)
                    selectedTab.deselect()
                selectedTab = this
            }
            Component.onCompleted: {
                if(index == defaultSelected) {
                    this.select()
                    selectedTab = this
                }
            }
        }
    }
}
