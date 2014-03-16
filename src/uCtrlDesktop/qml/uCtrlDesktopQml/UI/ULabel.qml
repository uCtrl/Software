import QtQuick 2.0

Text {
    property string label: "unknown"
    property bool justified: false
    property var textSize: [12, 24, 20, 18, 16, 12]
    property var textBold: [false, false, true, false, false, false]
    property var textColor: ["black", _colors.uGreen, _colors.uDarkGrey, _colors.uDarkGrey, _colors.uDarkGrey, _colors.uDarkGrey]
    property int headerStyle: 0

    font.family: "Calibri"
    wrapMode: Text.WordWrap
    text: formatText(label)

    Component.onCompleted: this.applyHeadingStyle(headerStyle)

    function formatText(label) {
        label = label.replace(/(\n|\r)/, "").replace(/\s+/g, " ")
        if (headerStyle == 5) label = label.toUpperCase()
        return label
    }

    // level indicates h1, h2, ..., h5. h0 resets text to normal
    function applyHeadingStyle(level) {
        font.pixelSize = textSize[level]
        font.bold = textBold[level]
        color = textColor[level]

        if (level === 1) centerHorizontally()
        else if (justified) justify()
    }

    function alignLeft() {
        horizontalAlignment = Text.AlignLeft
    }

    function centerHorizontally() {
        alignLeft()
        anchors.left = parent.left
        anchors.leftMargin = (parent.width / 2) - (width / 2)
    }

    function centerVertically() {
        alignLeft()
        anchors.verticalCenter = parent.verticalCenter
    }

    function justify() {
        horizontalAlignment = Text.AlignJustify
    }
}
