import QtQuick 2.0
import "../ui/UColors.js" as Colors

Repeater {
    id: conditionContainer
    property bool showEditMode: false
    clip: true

    delegate: Condition {
        x: 20
        showEditMode: conditionContainer.showEditMode
    }
}
