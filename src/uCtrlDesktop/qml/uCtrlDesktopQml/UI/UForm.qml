import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: container

    property bool isValid: false        // Always start with false value, then updated by children and validate()

    anchors.fill: parent

    width: parent.width; height: parent.height
    color: _colors.uTransparent

    function refreshChildren() {
       for (var i=0; i<container.children.length; i++) {
           try {
                container.children[i].refresh()
            } catch (ignore) {
                console.log("WARNING: Component inserted in a form with no refresh function.")
            }
        }
    }

    function validate() {
        var valid = true
        var index = 0

        while (valid && index<container.children.length) {
            try {
                if (valid && container.children[index].isValid !== undefined) valid = container.children[index].isValid
            } catch (err) {
                console.log("WARNING: Component inserted in a form with no validate function.")
            }

            index++;
        }

        isValid = valid
    }

    Component.onCompleted: validate()
}
