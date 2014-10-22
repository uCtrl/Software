import QtQuick 2.0

Rectangle {
    id: conditionsList

    property var model: null
    property int marginSize: 10

    width: parent.width - marginSize
    x: marginSize

    ListView {
        id: conditions

        model: conditionsList.model

        anchors.top: conditionsList.top
        anchors.bottom: conditionsList.bottom

        anchors.left: conditionsList.left
        anchors.right: conditionsList.right

        delegate: Column {
            id: column

            width: parent.width

            Condition {
                id: itemContainer

                width: parent.width

                item: model

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                }
            }
        }
    }
}
