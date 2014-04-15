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

        comparisonComboBox.reset()
        comparisonLabel.reset()

        beginValueTextbox.reset()
        beginValueSwitch.reset()
        endValueTextbox.reset()

        beginValueLabel.reset()
        endValueLabel.reset()

        unitLabel.reset()
    }

    function saveCondition() {
        deviceCondition.comparisonType = comparisonComboBox.selectedItem.value
        deviceCondition.deviceId = deviceComboBox.selectedItem.value
        deviceCondition.deviceType = deviceTypeComboBox.selectedItem.value

        if (isTriggerValue()) {
            deviceCondition.beginValue = beginValueSwitch.state === "ON" ? 1 : 0
        }
        else {
            deviceCondition.beginValue = parseFloat(beginValueTextbox.text)
        }

        deviceCondition.endValue = parseFloat(endValueTextbox.text)

        updateDisplay()
    }

    Component.onCompleted: {
        updateDisplay()
    }

    function cancelEditCondition() {
        if (!isEditMode)
            return

        deviceTypeComboBox.reset()
        deviceComboBox.reset()
    }

    function isTriggerValue() {
        var selectedDeviceType = deviceTypeComboBox.selectedItem.value

        for(var i = 0; i < deviceTypeUtility.length; i++) {
            if (selectedDeviceType === deviceTypeUtility[i].type) {
                return deviceTypeUtility[i].isTriggerValue
            }
        }
        return false
    }

    function getUnitLabel() {
        var selectedDeviceType = deviceTypeComboBox.selectedItem.value

        for(var i = 0; i < deviceTypeUtility.length; i++) {
            if (selectedDeviceType === deviceTypeUtility[i].type) {
                return deviceTypeUtility[i].unitLabel
            }
        }
        return ""
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

        onSelectedItemChanged: {
            deviceComboBox.reset()
            comparisonComboBox.reset()
            unitLabel.reset()
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

            setSelectedItem({"value":-1, "displayedValue":"Type...", "iconId":""})
        }

        function reset() {
            itemListModel = getItemListModel()
            selectDeviceType()
        }
    }

    ULabel.Default {
        id: deviceNameLabel

        anchors.verticalCenter: deviceTypeLabel.verticalCenter
        anchors.left: deviceTypeLabel.right
        anchors.leftMargin: 2

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

        function getItemListModel() {
            var deviceList = taskModel.getAllDevices()
            var deviceByTypeList = []

            for (var i = 0; i < deviceList.getDeviceCount(); i++) {
                var device = deviceList.getDeviceAt(i)

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

            setSelectedItem({"value":-1, "displayedValue":"Device...", "iconId":""})
        }

        function reset() {
            itemListModel = getItemListModel()
            selectDevice()
        }
    }

    ULabel.Default {
        id: isLabel

        anchors.verticalCenter: isEditMode ? deviceComboBox.verticalCenter : deviceNameLabel.verticalCenter
        anchors.left: isEditMode ? deviceComboBox.right : deviceNameLabel.right
        anchors.leftMargin: 2

        text: "status is "
    }

    ULabel.Default {
        id: comparisonLabel

        anchors.verticalCenter: isLabel.verticalCenter
        anchors.left: isLabel.right

        visible: !isEditMode

        text: getText()

        function getText() {
            switch(deviceCondition.comparisonType) {
            case UEComparisonType.GreaterThan:
                return "greater than "
            case UEComparisonType.LesserThan:
                return "lesser than "
            case UEComparisonType.Equals:
                return "equal "
            case UEComparisonType.InBetween:
                return "between "
            default:
                return ""
            }
        }

        function reset() {
            text = getText()
        }
    }

    UI.UComboBox {
        id: comparisonComboBox

        anchors.verticalCenter: isLabel.verticalCenter
        anchors.left: isLabel.right

        width: 125
        height: 30

        visible: isEditMode

        function getItemListModel() {
            var supportedComparisonType = []

            var currentDeviceType = deviceTypeComboBox.selectedItem.value
            var currentDeviceTypeUtility
            for (var i = 0; i < deviceTypeUtility.length; i++) {
                if (currentDeviceType === deviceTypeUtility[i].type) {
                    currentDeviceTypeUtility = deviceTypeUtility[i]
                    break
                }
            }

            if ((currentDeviceTypeUtility.comparisonType & UEComparisonType.GreaterThan) === UEComparisonType.GreaterThan)
                supportedComparisonType.push({"value":UEComparisonType.GreaterThan, "displayedValue":"greater than", "iconId":""})

            if ((currentDeviceTypeUtility.comparisonType & UEComparisonType.LesserThan) === UEComparisonType.LesserThan)
                supportedComparisonType.push({"value":UEComparisonType.LesserThan, "displayedValue":"lesser than", "iconId":""})

            if ((currentDeviceTypeUtility.comparisonType & UEComparisonType.Equals) === UEComparisonType.Equals)
                supportedComparisonType.push({"value":UEComparisonType.Equals, "displayedValue":"equal", "iconId":""})

            if ((currentDeviceTypeUtility.comparisonType & UEComparisonType.InBetween) === UEComparisonType.InBetween)
                supportedComparisonType.push({"value":UEComparisonType.InBetween, "displayedValue":"between", "iconId":""})

            return supportedComparisonType
        }

        function selectComparisonType() {
            for (var i = 0; i < itemListModel.length; i++) {
                if (deviceCondition.comparisonType === itemListModel[i].value) {
                    selectItem(i)
                    return
                }
            }

            setSelectedItem({"value":"", "displayedValue":"Comparison...", "iconId":""})
        }

        function reset() {
            itemListModel = getItemListModel()
            selectComparisonType()
        }
    }

    ULabel.Default {
        id: beginValueLabel

        visible: !isEditMode

        anchors.verticalCenter: comparisonLabel.verticalCenter
        anchors.left: comparisonLabel.right
        anchors.leftMargin: 2

        function reset() {
            if (isTriggerValue()) {
                text = deviceCondition.beginValue === 0 ? "OFF" : "ON"
            }
            else {
                text = deviceCondition.beginValue
            }
        }
    }

    UI.UTextbox {
        id: beginValueTextbox

        width: 30
        visible: isEditMode && !isTriggerValue()

        anchors.verticalCenter: comparisonComboBox.verticalCenter
        anchors.left: comparisonComboBox.right
        anchors.leftMargin: 2

        function reset() {
            text = deviceCondition.beginValue
        }
    }

    UI.USwitch {
        id: beginValueSwitch

        anchors.verticalCenter: comparisonComboBox.verticalCenter
        anchors.left: comparisonComboBox.right
        anchors.leftMargin: 2

        visible: isEditMode && isTriggerValue()

        function reset() {
            state = deviceCondition.beginValue === 0 ? "OFF" : "ON"
        }
    }

    ULabel.Default {
        id: andLabel

        text: "and"

        anchors.verticalCenter: isEditMode ? (isTriggerValue() ? beginValueSwitch.verticalCenter : beginValueTextbox.verticalCenter)
                                           : beginValueLabel.verticalCenter
        anchors.left: isEditMode ? (isTriggerValue() ? beginValueSwitch.right : beginValueTextbox.right)
                                 : beginValueLabel.right
        anchors.leftMargin: 2

        visible: (comparisonComboBox.selectedItem.value & UEComparisonType.InBetween) === UEComparisonType.InBetween
    }

    ULabel.Default {
        id: endValueLabel

        anchors.verticalCenter: andLabel.verticalCenter
        anchors.left: andLabel.right
        anchors.leftMargin: 2

        visible: !isEditMode
                 && (comparisonComboBox.selectedItem.value & UEComparisonType.InBetween) === UEComparisonType.InBetween

        function reset() {
            text = deviceCondition.endValue
        }
    }

    UI.UTextbox {
        id: endValueTextbox

        width: 30
        anchors.verticalCenter: andLabel.verticalCenter
        anchors.left: andLabel.right
        anchors.leftMargin: 2

        visible: isEditMode && (comparisonComboBox.selectedItem.value & UEComparisonType.InBetween) === UEComparisonType.InBetween

        function reset() {
            text = deviceCondition.endValue
        }
    }

    ULabel.Default {
        id: unitLabel

        anchors.verticalCenter: ((comparisonComboBox.selectedItem.value & UEComparisonType.InBetween) === UEComparisonType.InBetween)
                                ? isEditMode ? endValueTextbox.verticalCenter : endValueLabel.verticalCenter
                                : isEditMode ? beginValueLabel.verticalCenter : isTriggerValue() ? beginValueSwitch.verticalCenter : beginValueTextbox.verticalCenter
        anchors.left: ((comparisonComboBox.selectedItem.value & UEComparisonType.InBetween) === UEComparisonType.InBetween)
                      ? (isEditMode ? endValueTextbox.right : endValueLabel.right)
                      : (isEditMode ? (isTriggerValue() ? beginValueSwitch.right : beginValueTextbox.right) : beginValueLabel.right)
        anchors.leftMargin: 2


        function reset() {
            text = getUnitLabel()
            console.log(text)
        }
    }
}
