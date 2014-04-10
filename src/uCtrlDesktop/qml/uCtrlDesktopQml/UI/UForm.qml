import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: container

    property bool isValid: false        // Always start with false value, then updated by children and validate()
    property var controlsToValidate : []

    anchors.fill: parent

    width: 0
    height: 0
    color: _colors.uTransparent

    signal afterValidate

    function refreshChildren() {
       for (var i=0; i< controlsToValidate.length; i++) {
           try {
                controlsToValidate[i].refresh()
            } catch (ignore) {
                console.log("WARNING: Component inserted in a form with no refresh function.")
            }
        }
    }

    function validate() {
        var valid = true
        for(var i = 0; i < controlsToValidate.length; i++) {
            try {
                valid &= controlsToValidate[i].validate()
            } catch (err) {
                console.log("WARNING: Component inserted in a form with no validate function.")
            }
        }

        isValid = valid
        container.afterValidate()

        return valid
    }

    Component.onCompleted: validate()
}
