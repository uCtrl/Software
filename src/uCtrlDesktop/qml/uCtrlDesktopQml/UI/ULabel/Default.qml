import QtQuick 2.0

Text {
    id: dflt
    font.family: "Lato"
    font.pointSize: 12
    renderType: Text.NativeRendering
    wrapMode: Text.WordWrap
    color: _colors.uBlack

    onTextChanged: {
        var newValue = dflt.text.replace(/(\n|\r)/, "").replace(/\s+/g, " ")
        dflt.text = newValue
    }

    Component.onCompleted: {
        if(CrossPlatformOS.getOS() === 1){
           dflt.font.pointSize *= 0.90;
        }
    }
}
