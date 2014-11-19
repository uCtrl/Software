import QtQuick 2.0
import "../ui/UColors.js" as Colors

Text {
    id: dflt
    font.family: "Lato"
    font.pointSize: 12
    wrapMode: Text.WordWrap
    color: Colors.uWhite
    text: ""

    /*onTextChanged: {
        var newValue = dflt.text.replace(/(\n|\r)/, "").replace(/\s+/g, " ")
        dflt.text = newValue
    }*/
}
