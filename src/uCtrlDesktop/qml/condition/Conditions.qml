import QtQuick 2.0
import "../ui/UColors.js" as Colors

Repeater {
    clip: true

    delegate: Condition {
        x: 10
    }
}
