import QtQuick 2.0

Rectangle {
    id: tabs

    property var icons: []
    property var selectedTab
    property int iconSize : 16
    property int defaultSelected: 0

    width: 200
    height: 40

    color: _colors.uTransparent

    ListView {
        id: list
        model: icons
        anchors.fill: parent
        delegate: tab
        orientation: ListView.Horizontal
    }
    Component {
        id: tab
        UTab {
            isFirst: (index == 0)
            isLast: (index == icons.length - 1)
            iconId: icons[index]
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
