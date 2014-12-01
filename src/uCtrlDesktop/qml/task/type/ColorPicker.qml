import QtQuick 2.0

import "../../ui" as UI
import "../../ui/UColors.js" as Colors

Rectangle {
    id: container

    color: Colors.uTransparent

    property var model
    UI.UCompactColorPicker
    {
        id: colorPicker
        width: 130
        height: 30

        anchors.centerIn: parent
        Component.onCompleted: {
            taskEditorContainer.saveConditions.connect(saveState)

            hsbFromRgb("#" + model.value())

            saturation = 1
            value = 1
        }

        function saveState()
        {
            console.log("SaveSet: " + pickerString)
            model.value(pickerString)
        }
    }
}
