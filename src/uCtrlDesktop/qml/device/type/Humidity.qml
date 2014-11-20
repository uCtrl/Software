import QtQuick 2.0

import "../../ui" as UI
import "../../ui/UColors.js" as Colors
import "../../label" as ULabel
import "../../jbQuick/Charts/QChart.js" as Charts

Rectangle {
    id: deviceInformation
    property bool showEditMode: false

    anchors.fill: parent
    Column
    {
        id: infoContainer
        width: parent.width
        spacing: 5

        property variant model: main.activeDevice

        property int headerWidth: 150
        property int valueWidth: width - headerWidth
        property int standardRowHeight: 40

        Rectangle
        {
            id: header
            width: parent.width
            height: 50

            Rectangle
            {
                id: deviceIconContainer
                width: parent.height
                height: parent.height

                radius: 10
                color: {
                    switch(getDeviceStatus())
                    {
                    case 0:
                        return Colors.uGreen; //OK
                    case 1:
                        return Colors.uYellow; //Disconnected
                    case 2:
                        return Colors.uRed; //Warning
                    }


                }

                UI.UFontAwesome
                {
                    iconId: "droplet"
                    iconColor: Colors.uWhite
                    iconSize: 20
                    anchors.centerIn: parent
                }
            }

            Rectangle
            {
                id: nameEdit
                anchors.left: deviceIconContainer.right
                anchors.right: parent.right
                height: parent.height

                visible: showEditMode
                UI.UTextbox {
                    id: nameTextbox
                    width: parent.width

                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.right: saveCancelButton.left
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter

                    text: getDeviceName()
                    placeholderText: "Enter a device name"

                    function validate() {
                        return text !== ""
                    }

                    visible: showEditMode

                    state: (validate() ? "SUCCESS" : "ERROR")
                }

                UI.USaveCancel
                {
                    id: saveCancelButton
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right

                    onSave: saveForm()
                    onCancel: toggleEditMode()

                    visible: showEditMode
                }
            }

            Rectangle
            {
                id: readOnlyContainer
                anchors.left: deviceIconContainer.right
                anchors.right: parent.right
                height: parent.height

                visible: !showEditMode
                ULabel.Description
                {
                    text: getDeviceName()
                    font.pointSize: 22

                    anchors.verticalCenter: parent.verticalCenter

                    anchors.left: parent.left
                    anchors.right: editButton.left

                    anchors.margins: 10
                }

                UI.UButton {
                    id: editButton

                    iconId: "pencil"

                    iconSize: 22

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.right: parent.right

                    width: 50
                    height: 50

                    buttonTextColor: Colors.uGrey
                    buttonColor: Colors.uTransparent
                    buttonHoveredTextColor: Colors.uGreen
                    buttonHoveredColor: Colors.uTransparent

                    onClicked: showEditMode = true
                }
            }
        }

        Column
        {
            id: alwaysShownInfoContainer
            width: parent.width

            Rectangle
            {
                width: parent.width
                height: infoContainer.standardRowHeight

                ULabel.DeviceInfoHeaderLabel { text: "Enabled"; width: infoContainer.headerWidth }
                Rectangle
                {
                    anchors.right: parent.right
                    width: infoContainer.valueWidth
                    height: parent.height

                    ULabel.UInfoBoundedLabel
                    {
                        text: getDeviceEnabled()
                        visible: !showEditMode
                        boundedColor: text === "ON" ? Colors.uGreen : Colors.uGrey
                    }
                    UI.USwitch {
                        id: editEnabled
                        anchors.verticalCenter: parent.verticalCenter
                        state: getDeviceEnabled()
                        visible: showEditMode
                    }
                }
            }

            Rectangle
            {
                width: parent.width
                height: infoContainer.standardRowHeight

                ULabel.DeviceInfoHeaderLabel { text: "Status"; width: infoContainer.headerWidth }
                Rectangle
                {
                    anchors.right: parent.right
                    width: infoContainer.valueWidth
                    height: parent.height

                    ULabel.UInfoBoundedLabel
                    {
                        text: getDeviceValue() + getDeviceUnitLabel()
                    }
                }
            }

            Rectangle
            {
                width: parent.width
                height: {
                    if(descriptionLabel.height + 11 > infoContainer.standardRowHeight)
                        return descriptionLabel.height + 11
                    return infoContainer.standardRowHeight
                }

                Rectangle
                {
                    width: parent.width
                    height: infoContainer.standardRowHeight

                    ULabel.DeviceInfoHeaderLabel { text: "Description"; width: infoContainer.headerWidth }
                }
                Rectangle
                {
                    anchors.right: parent.right
                    width: infoContainer.valueWidth
                    height: parent.height

                    UI.UTextbox
                    {
                        id: editDescription
                        anchors.top: parent.top
                        anchors.topMargin: 2
                        height: infoContainer.standardRowHeight

                        width: parent.width
                        visible: showEditMode
                        placeholderText: "Enter a device description"
                        text: getDeviceDescription()

                        function validate() {
                            return true
                        }
                    }

                    ULabel.Default
                    {
                        id: descriptionLabel
                        anchors.top: parent.top
                        anchors.topMargin: 11
                        width: parent.width
                        text: getDeviceDescription()
                        font.pointSize: 14

                        visible: !showEditMode
                    }
                }
            }
        }

        Column
        {
            property int openedHeight: 0
            property bool isCollapsed: true

            id: moreInfoContainer
            width: parent.width

            Component.onCompleted: {
                openedHeight = moreInfoContainer.height
                moreInfoContainer.height = 0

                expandInfoContainer.to = openedHeight
            }

            NumberAnimation
            {
                id: expandInfoContainer;
                target: moreInfoContainer;
                properties: "height";
                duration: 200;
                easing.type: Easing.InOutQuad
            }
            NumberAnimation
            {
                id: collapseInfoContainer;
                target: moreInfoContainer;
                properties: "height";
                to: 0;
                duration: 200;
                easing.type: Easing.InOutQuad
            }

            function toggle()
            {
                if(isCollapsed)
                {
                    expandInfoContainer.start()
                    isCollapsed = false
                }
                else
                {
                    collapseInfoContainer.start()
                    isCollapsed = true
                }
                return isCollapsed;
            }

            Rectangle
            {
                width: parent.width
                height: infoContainer.standardRowHeight

                ULabel.DeviceInfoHeaderLabel { text: "Type"; width: infoContainer.headerWidth }
                ULabel.DeviceInfoValueLabel { text: "Humidity sensor"; width: infoContainer.valueWidth }
            }
            Rectangle
            {
                width: parent.width
                height: infoContainer.standardRowHeight

                ULabel.DeviceInfoHeaderLabel { text: "Units"; width: infoContainer.headerWidth }
                ULabel.DeviceInfoValueLabel { text: getDeviceUnitLabel(); width: infoContainer.valueWidth }
            }
            Rectangle
            {
                width: parent.width
                height: infoContainer.standardRowHeight

                ULabel.DeviceInfoHeaderLabel { text: "Range"; width: infoContainer.headerWidth }
                ULabel.DeviceInfoValueLabel { text: getDeviceRange(); width: infoContainer.valueWidth }
            }
            Rectangle
            {
                width: parent.width
                height: infoContainer.standardRowHeight

                ULabel.DeviceInfoHeaderLabel { text: "GUID"; width: infoContainer.headerWidth }
                ULabel.DeviceInfoValueLabel { text: "ffab-346ddf1-c234a3c-1259afc"; width: infoContainer.valueWidth }
            }
            Rectangle
            {
                width: parent.width
                height: infoContainer.standardRowHeight

                ULabel.DeviceInfoHeaderLabel { text: "Modele"; width: infoContainer.headerWidth }
                ULabel.DeviceInfoValueLabel { text: "TCa4V38-2"; width: infoContainer.valueWidth }
            }
        }

        Rectangle
        {
            id: moreInfoLabelContainer

            width: parent.width
            height: 25

            Rectangle
            {
                width: parent.width
                height: devicePage.bottomMarginSize
                color: Colors.uTransparent

                UI.UFontAwesome
                {
                    id: moreInfoIcon
                    iconId: "PlusSign"
                    iconSize: 12
                    iconColor: Colors.uGrey
                    anchors.right: moreInfoText.left
                    anchors.rightMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                }
                ULabel.Link
                {
                    id: moreInfoText
                    text: "More information"
                    anchors.right: parent.right
                    color: Colors.uGrey
                    anchors.verticalCenter: parent.verticalCenter

                    onHyperLinkClicked: {
                        var isCollapsed = moreInfoContainer.toggle();

                        if(isCollapsed)
                        {
                            moreInfoIcon.iconId = "PlusSign"
                            moreInfoText.text = "More information"
                        }
                        else
                        {
                            moreInfoIcon.iconId = "MinusSign"
                            moreInfoText.text = "Less information"
                        }
                    }

                }

                anchors.bottom: parent.bottom
            }
        }
    }

    Rectangle
    {
        id: topAndBottomSeparator
        color: Colors.uLightGrey
        width: parent.width
        height: 2

        anchors.top: infoContainer.bottom
    }

    Rectangle
    {
        id: statsContainer
        width: parent.width
        anchors.top: topAndBottomSeparator.bottom
        anchors.bottom: parent.bottom

        Rectangle
        {
            id: chartContainer
            anchors.top: statsHeader.bottom
            anchors.bottom: carouselContainer.top

            clip: true
            width: parent.width

            UI.UChart {
                id: stateChart
                chartAnimated: false
                chartName: "Daily status"
                chartData: {
                               "labels": ["06:10am","07:10am","08:10am","09:10am","10:10am","11:10am","12:10am"],
                               "axisY": [0, 25, 50, 75, 100],
                               "datasets": [{
                                   fillColor: "rgba(237,237,237,0.5)",
                                   strokeColor: Colors.uMediumLightGrey,
                                   pointColor: Colors.uGreen,
                                   pointStrokeColor: Colors.uGreen,
                                   data: [0, 55, 15, 75, 100, 0, 50],
                               }]
                           }
                width: chartContainer.width
                height: chartContainer.height
                chartType: Charts.ChartType.LINE
            }

            UI.UChart {
                id: powerChart
                chartAnimated: false
                chartName: "Power consumption"
                chartData: {
                               "labels": ["06:10am","07:10am","08:10am","09:10am","10:10am","11:10am","12:10am"],
                               "axisY": [0, 25, 50, 75, 100],
                               "datasets": [{
                                   fillColor: "rgba(237,237,237,0.5)",
                                   strokeColor: Colors.uMediumLightGrey,
                                   pointColor: Colors.uGreen,
                                   pointStrokeColor: Colors.uGreen,
                                   data: [0, 15, 20, 23, 25, 60, 67]
                               }]
                           }
                width: chartContainer.width
                height: chartContainer.height
                chartType: Charts.ChartType.LINE
            }
        }

        Rectangle
        {
            id: carouselContainer
            width: parent.width
            height: 30
            anchors.bottom: parent.bottom

            UI.UCarousel {
                carouselItems:  [stateChart, powerChart]
                carouselIcons: ["info", "lightning"]
                onChangeItem: {
                    statsText.text = "Statistics : " + item.chartName
                }
            }
        }

        Rectangle
        {
            id: statsHeader
            width: parent.width
            height: 40

            UI.UFontAwesome
            {
                id: statsIcon
                iconId: "stats"
                iconSize: 12
                iconColor: Colors.uGrey
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
            }
            ULabel.Default
            {
                id: statsText
                text: "Statistics"
                anchors.left: statsIcon.right
                anchors.leftMargin: 15
                color: Colors.uGrey
                anchors.verticalCenter: parent.verticalCenter
                font.bold: true
            }

            UI.UCombobox
            {
                id: periodCombo

                property var periods: [
                    { value: "today",     displayedValue: "Today", iconId: ""},
                    { value: "week",   displayedValue: "This week", iconId: ""},
                    { value: "month",   displayedValue: "This month", iconId: ""},
               ]

                itemListModel: periods

                anchors.right: parent.right

                itemColor: Colors.uTransparent
                itemTextColor: Colors.uGreen

                dropdownColor: Colors.uGreen
                dropdownTextColor: Colors.uWhite

                selectedItemColor: Colors.uDarkGreen
                selectedItemTextColor: Colors.uWhite
                selectedItemHoverColor: Colors.uWhite
                selectedItemHoverTextColor: Colors.uGreen

                hoverColor: Colors.uDarkGreen
                hoverTextColor: Colors.uWhite

                height: parent.height;
                width: 150

                Component.onCompleted: selectItem(0)

                z: 3
            }
        }
    }

    function getDeviceName() {
        if (model !== null) return model.name
        else return "Unknown device name"
    }

    function getDeviceEnabled() {
        if (model !== null) return model.isEnabled ? "ON" : "OFF"
        else return "OFF"
    }

    function getDeviceDescription() {
        if (model !== null) return model.description
        else return ""
    }

    function getDeviceMinValue()
    {
        if (model !== null) return model.minValue
        else return 0
    }

    function getDeviceMaxValue()
    {
        if (model !== null) return model.maxValue
        else return 0
    }

    function getDeviceRange()
    {
        return "[" + getDeviceMinValue() + "-" + getDeviceMaxValue() + "]"
    }

    function getDeviceStatus()
    {
        if (model !== null) return model.status
        else return 2
    }

    function getDeviceUnitLabel()
    {
        if (model !== null) return model.unitLabel
        else return ""
    }

    function getDeviceValue()
    {
        if (model !== null) return model.value
        else return -1
    }

    function saveForm() {
        if (model !== null) {

            if (!nameTextbox.validate() || !editDescription.validate())
            {
                return;
            }

            model.name = nameTextbox.text
            model.isEnabled = editEnabled.state === "ON" ? true : false
            model.description = editDescription.text
        }

        toggleEditMode()
    }

    function toggleEditMode() {
        if (model !== null) {
            nameTextbox.text = getDeviceName()
            editEnabled.state = getDeviceEnabled()
            descriptionLabel.text = getDeviceDescription()
        }

        showEditMode = !showEditMode
    }
}
