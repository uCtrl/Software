import QtQuick 2.0
import "../UI" as UI
import "../UI/ULabel" as ULabel
import ConditionEnums 1.0

Rectangle {

    property var deviceCondition
    property var deviceTypeUtility: [
                                        {   type:UEDeviceType.Temperature,
                                            name:"Temperature",
                                            icon:"",
                                            unitLabel:"\u00B0C",
                                            isTriggerValue:false,
                                            comparisonType:(UEComparisonType.GreaterThan | UEComparisonType.LesserThan | UEComparisonType.InBetween)
                                        },
                                        {   type:UEDeviceType.MotionSensor,
                                            name:"Motion Sensor",
                                            icon:"",
                                            unitLabel:"",
                                            isTriggerValue:true,
                                            comparisonType:(UEComparisonType.Equals)
                                        },
                                        {   type:UEDeviceType.LightSensor,
                                            name:"Light Sensor",
                                            icon:"",
                                            unitLabel:"%",
                                            isTriggerValue:false,
                                            comparisonType:(UEComparisonType.GreaterThan | UEComparisonType.LesserThan | UEComparisonType.InBetween)
                                        },
                                        {   type:UEDeviceType.Light,
                                            name:"Light",
                                            icon:"",
                                            unitLabel:"",
                                            isTriggerValue:true,
                                            comparisonType:(UEComparisonType.Equals)
                                        },
                                        {   type:UEDeviceType.ElectricPlug,
                                            name:"Electric Plug",
                                            icon:"",
                                            unitLabel:"",
                                            isTriggerValue:true,
                                            comparisonType:(UEComparisonType.Equals)
                                        }
                                    ]

    property bool isEditMode: false

    onIsEditModeChanged: {
        console.log("edit mode changed")
    }

    anchors.left: parent.left
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    width: parent.width - 30
    height: parent.height - 5

    function saveCondition() {

    }

    function cancelEditCondition() {

    }

    UI.UFontAwesome {
        id: deviceIcon

        width: parent.height
        height: parent.height

        iconId: "QuestionSign"
        iconSize: 16
        iconColor: _colors.uBlack
        anchors.left: parent.left

    }

    ULabel.Default {
        text: getText()

        anchors.verticalCenter: deviceIcon.verticalCenter
        anchors.left: deviceIcon.right

        visible: !isEditMode

        function getText() {
            if (!visible)
                return ""

            for (var i = 0; i < deviceTypeUtility.length; i++) {
                if (deviceCondition.deviceType === deviceTypeUtility[i].type) {
                    return deviceTypeUtility[i].name
                }
            }
        }
    }

    UI.UComboBox {
        id: deviceTypeComboBox

        anchors.verticalCenter: deviceIcon.verticalCenter
        anchors.left: deviceIcon.right

        width: 150
        height: 30

        visible: isEditMode

        itemListModel: getItemListModel()

        function getItemListModel() {
            var deviceTypeList = []

            for (var i = 0; i < deviceTypeUtility.length; i++) {
                deviceTypeList.push({"value":deviceTypeUtility[i].type, "displayedValue":deviceTypeUtility[i].name, iconId:""})
            }

            return deviceTypeList
        }

        Component.onCompleted: {
            // TODO changed for select by value of Harmel
            for (var i = 0; i < deviceTypeUtility.length; i++) {
                if (deviceCondition.deviceType === deviceTypeUtility[i].type) {
                    selectItem(i)
                    break
                }
            }
        }
    }

    UI.UComboBox {
        anchors.verticalCenter: deviceTypeComboBox.verticalCenter
        anchors.left: deviceTypeComboBox.right
        anchors.leftMargin: 10

        width: 150
        height: 30

        visible: isEditMode

        itemListModel: getItemListModel()

        function getItemListModel() {
            var deviceList = taskModel.getAllDevicesByType(deviceTypeComboBox.selectedItem.value)
            var deviceByTypeList = []

            for (var i = 0; i < deviceList.getDeviceCount(); i++) {
                var device = deviceList.getDeviceAt(i)
                deviceByTypeList.push({"value":device.id, "displayedValue":device.name, "iconId":""})
            }
/*
            if (deviceByTypeList.length === 0) {
                selectedItem = {"value":"", "displayedValue":"", "iconId":""}
            }
*/
            return deviceByTypeList
        }
    }
}
