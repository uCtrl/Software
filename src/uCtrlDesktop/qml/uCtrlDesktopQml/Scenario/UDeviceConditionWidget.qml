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

    anchors.left: parent.left
    anchors.leftMargin: 30
    anchors.verticalCenter: parent.verticalCenter

    width: parent.width - 30
    height: parent.height - 5

    function updateDisplay() {
        deviceTypeComboBox.reset()
        deviceComboBox.reset()

        if (deviceTypeComboBox.selectedItem !== undefined) {
            deviceTypeLabel.text = deviceTypeComboBox.selectedItem.displayedValue
            deviceNameLabel.text = deviceComboBox.selectedItem.value !== -1 ? deviceComboBox.selectedItem.displayedValue : ""
        }
    }

    function saveCondition() {
        deviceCondition.deviceId = deviceComboBox.selectedItem.value
        deviceCondition.deviceType = deviceTypeComboBox.selectedItem.value

        updateDisplay()
    }

    Component.onCompleted: {
        console.log("COMPONENT COMPLETED")
        console.log("type: " + deviceCondition.type)
        console.log("id:" + deviceCondition.id)
        updateDisplay()
    }

    function cancelEditCondition() {
        if (!isEditMode)
            return

        deviceTypeComboBox.reset()
        deviceComboBox.reset()
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
        id: deviceTypeLabel

        //text: getText()

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

        function reset() {
            text = getText()
        }
    }

    UI.UComboBox {
        id: deviceTypeComboBox

        anchors.verticalCenter: deviceIcon.verticalCenter
        anchors.left: deviceIcon.right

        width: 150
        height: 30

        visible: isEditMode

        //itemListModel: getItemListModel()
        //selectedItem: getSelectedItem()
        onSelectedItemChanged: {
            deviceComboBox.reset()
        }

        function getItemListModel() {
            var deviceTypeList = []

            for (var i = 0; i < deviceTypeUtility.length; i++) {
                deviceTypeList.push({"value":deviceTypeUtility[i].type, "displayedValue":deviceTypeUtility[i].name, iconId:""})
            }

            return deviceTypeList
        }

        function selectDeviceType() {
            for (var i = 0; i < deviceTypeUtility.length; i++) {
                if (deviceCondition.deviceType === deviceTypeUtility[i].type) {
                    selectItem(i)
                    return
                }
            }

            setSelectedItem({"value":-1, "displayedValue":"Select a type", "iconId":""})
        }

        function reset() {
            itemListModel = getItemListModel()
            selectDeviceType()
        }
    }

    ULabel.Default {
        id: deviceNameLabel

        //text: getText()

        anchors.verticalCenter: deviceTypeComboBox.verticalCenter
        anchors.left: deviceTypeComboBox.right

        visible: !isEditMode

        function getText() {
            if (deviceComboBox.selectedItem.value === -1)
                return ""

            return deviceComboBox.selectedItem.displayedValue
        }
    }

    UI.UComboBox {
        id: deviceComboBox

        anchors.verticalCenter: deviceTypeComboBox.verticalCenter
        anchors.left: deviceTypeComboBox.right
        anchors.leftMargin: 10

        width: 150
        height: 30

        visible: isEditMode

        //itemListModel: getItemListModel()

        function getItemListModel() {
            var deviceList = taskModel.getAllDevices()
            var deviceByTypeList = []

            console.log("DEVICE COMBO BOX")
            for (var i = 0; i < deviceList.getDeviceCount(); i++) {
                var device = deviceList.getDeviceAt(i)

                console.log(device.id)
                if (taskModel.scenario.device.id === device.id)
                    continue

                if (deviceTypeComboBox.selectedItem.value === device.type)
                    deviceByTypeList.push({"value":device.id, "displayedValue":device.name, "iconId":""})
            }

            return deviceByTypeList
        }

        function selectDevice() {
            for (var i = 0; i < itemListModel.length; i++) {
                if (itemListModel[i].value === deviceCondition.deviceId) {
                    selectItem(i)
                    return
                }
            }

            setSelectedItem({"value":-1, "displayedValue":"Select a device", "iconId":""})
        }

        function reset() {
            itemListModel = getItemListModel()
            selectDevice()
        }
    }
}
