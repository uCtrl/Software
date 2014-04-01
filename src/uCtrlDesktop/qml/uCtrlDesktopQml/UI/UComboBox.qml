import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

import "../UI/ULabel" as ULabel

ComboBox {
    id: comboBox
    width: 100
    height: 30
    model: [ "ON", "90%", "80%", "70%", "60%", "50%", "40%", "30%", "20%", "10%", "OFF" ]

    style: ComboBoxStyle {
        background: Rectangle {
            id: rectCategory
            anchors.fill: parent
            color: _colors.uGreen
            radius: 5
            border.width: 1
            border.color: _colors.uDarkGrey
        }

        label: Item {
            anchors.fill: parent
            Rectangle {
                id: arrow
                width: parent.height
                height: parent.height
                anchors.right: parent.right
                color: _colors.uTransparent

                UImage {
                    anchors.fill: parent
                    img: "qrc:///Resources/Images/Combobox-arrow.png"
                }
            }
            Rectangle {
                id: labelContainer
                anchors.left: parent.left
                anchors.right: arrow.left
                height: parent.height
                color: _colors.uTransparent

                ULabel.Heading3 {
                    id: label
                    anchors.centerIn: parent
                    text: control.currentText
                }
            }
        }
    }
}
