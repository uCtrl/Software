import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    id: container

    anchors.fill: parent

    width: parent.width; height: parent.height
    color: _colors.uTransparent

    function validate() {
        var valid = true;

        for (var i=0; i<container.children.length; i++) {
            if (valid) {
                try {
                    valid = container.children[i].validate()
                } catch (err) {
                    console.log("WARNING: Component inserted in a form with no validate function.")
                }
            }
        }

        return valid
    }
}
