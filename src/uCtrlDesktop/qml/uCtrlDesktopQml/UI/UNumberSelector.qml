import QtQuick 2.0

Rectangle {
    id: numberSelector
    width: 100
    height: 100

    color: _colors.uTransparent

    property int currentValue : 0
    property int minValue: 0
    property int maxValue: 100
    property int offsetPerClick : 1
    property bool fireTextChangedEvent : true

    signal overflow
    signal underflow

    Component.onCompleted: {
        changeValue(currentValue, true)
    }

    function getFormattedCurrentValue()
    {
        return formatValue(currentValue)
    }

    function formatValue(value)
    {
        var formattedValue = ("0000000000000" + value).slice(-2)
        return formattedValue
    }

    function addOffset() {
        changeValue(currentValue + offsetPerClick, true)
    }
    function removeOffset() {
        changeValue(currentValue - offsetPerClick, true)
    }

    function changeValue(newValue, formatText) {
        if(!isNaN(newValue)) {
            currentValue = newValue

            fireTextChangedEvent = false

            if(currentValue > maxValue) {
                currentValue = minValue
                numberSelector.overflow()
            } else if(currentValue < minValue) {
                currentValue = maxValue
                numberSelector.underflow()
            }

            var valueFormatted = ""
            if(formatText) {
                valueFormatted = getFormattedCurrentValue()
            } else {
                valueFormatted = currentValue
            }

            valueTextbox.text = valueFormatted

            fireTextChangedEvent = true
        }
    }

    UButton {
        id: upButton

        anchors.top: parent.top
        anchors.bottom: valueTextbox.top
        anchors.bottomMargin: 5

        width: parent.width
        height: 30

        iconId: "ChevronUp"
        buttonTextColor: _colors.uGrey
        buttonColor: _colors.uTransparent
        buttonHoveredColor: _colors.uLightGrey

        onClicked: {
            changeValue(currentValue + offsetPerClick, true)
        }
    }

    UTextbox {
        id: valueTextbox
        width: parent.width
        height: 30
        text: defaultValue
        anchors.centerIn: parent
        textAlignment: TextInput.AlignHCenter

        onTextChanged: {
            if(fireTextChangedEvent) {
                changeValue(parseInt(text), false)
            }
        }
    }

    UButton {
        id: downButton

        anchors.top: valueTextbox.bottom
        anchors.topMargin: 5
        anchors.bottom: parent.bottom

        width: parent.width
        height: 30

        iconId: "ChevronDown"
        buttonTextColor: _colors.uGrey
        buttonColor: _colors.uTransparent
        buttonHoveredColor: _colors.uLightGrey

        onClicked: {
            changeValue(currentValue - offsetPerClick, true)
        }
    }


}
