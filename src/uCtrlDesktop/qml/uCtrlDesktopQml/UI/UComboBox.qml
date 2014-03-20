import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Controls.Styles 1.0

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
                color: "transparent"

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
                color: "transparent"

                ULabel {
                    id: label
                    anchors.centerIn: parent
                    text: control.currentText
                    headerStyle: 3
                    Component.onCompleted: color=_colors.uWhite
                }
            }
        }
    }
}
