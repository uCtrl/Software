import QtQuick 2.0
import "../ui/UColors.js" as Colors

Default {
    id: h5

    font.pointSize: 12
    color: Colors.uDarkGrey
    onTextChanged: {
        var newValue = h5.text.toUpperCase()
        h5.text = newValue
    }
}
