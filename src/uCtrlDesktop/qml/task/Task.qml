import QtQuick 2.0

import "../ui" as UI
import "../label" as ULabel
import "../condition" as Condition
import "../ui/UColors.js" as Colors

Rectangle {

    id: container

    property var item: null

    height: taskContainer.height + conditionsContainer.height

    color: Colors.uLightGrey

    Rectangle {
        id: taskContainer

        width: parent.width; height: 25
        color: Colors.uLightGrey

        ULabel.Default {
            id: taskLabel

            anchors.left: parent.left
            anchors.leftMargin: 10

            anchors.verticalCenter: parent.verticalCenter

            text: "TASK"

            font.bold: false
            font.pointSize: 10

            color: Colors.uGrey
        }

        ULabel.Default {
            id: indexLabel

            anchors.left: taskLabel.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: "#" + (index + 1)

            font.bold: true
            font.pointSize: 10

            color: Colors.uGreen
        }

        ULabel.Default {
            id: separator

            anchors.left: indexLabel.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: " - SET TO "

            font.bold: true
            font.pointSize: 10

            color: Colors.uGrey

        }

        ULabel.Default {
            id: valueLabel

            anchors.left: separator.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: getValue()

            color: Colors.uGreen

            font.bold: true
            font.pointSize: 10
        }

        ULabel.Default {
            id: whenLabel

            anchors.left: valueLabel.right
            anchors.leftMargin: 3

            anchors.verticalCenter: parent.verticalCenter

            text: " WHEN"

            color: Colors.uGrey

            font.bold: false
            font.pointSize: 10
        }
    }

    Condition.Conditions {
        id: conditionsContainer

        model: getConditions()

        anchors.top: taskContainer.bottom
        anchors.topMargin: 20

        anchors.left: parent.left
        anchors.leftMargin: 10

        anchors.right: parent.right
    }

    function getValue() {
        //if (item !== null) return item.value
        //else return "ON"

        return "ON"
    }

    function getConditions() {
        if (item !== null) return tasks.model.nestedModelFromId(item.id)
    }
}
