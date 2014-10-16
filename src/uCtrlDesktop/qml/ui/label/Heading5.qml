import QtQuick 2.0

Default {
    id: h5

    font.pointSize: 12
    color: _colors.uDarkGrey
    onTextChanged: {
        var newValue = h5.text.toUpperCase()
        h5.text = newValue
    }
}
