import QtQuick 2.0
import ConditionEnums 1.0
import "../UI" as UI
import "../UI/ULabel" as ULabel

Rectangle{

    property bool isEditMode: false

    anchors.fill: parent
    color: isEditMode ? "red" : "blue"
}

