function loadResource(resourceName) {
    return resourceDictionary[resourceName]
}


var resourceDictionary = {

    // Home Page
    "iconHomeSize": 0.35,
    "labelHomeSize": 24,

    // NavBar.qml
    "navbarItemHeight": 150,
    "navbarWidth": 130,
    "navbarIconSize": 50,

    //TitleBar.qml
    "titlebarheight": 100,
    "titlebarBreadcrumbheight": 75,
    "titlebarBreadcrumbRightmargin": 45,

    "errorContainerParentFontPointSize": 30,

    //device/type/Sensor.qml
        "sensorUpdatecontainerHeight": 70,
            "sensorUpdateiconSize": 25,
            "sensorUpdateiconLeftMargin": 25,
            "sensorUpdatelabelFontPixeSize": 30,
            "sensorUpdatelabelLeftMargin": 30,

            "sensorGraphheaderHeight": 70,
            "sensorGraphheaderStatsiconSize": 25,
            "sensorGraphheaderStatsIconLeftMargin": 25,
            "sensorGraphtextStatstextFontPixeSize": 30,
            "sensorGraphtextStatstextLeftmargin": 30,
            "sensorGraphheaderPeriodcomboWidth": 300,
            "sensorCarouselcontainerHeight": 60,


    "temperatureValuecontainerHeight": 150,
    "temperatureValuecontainerWidth": 250,
    "temperatureValuecontainerCurrentValuelabelFontPixelSize": 20,
    "temperatureValuecontainerCurrentValuecontainerCurrentvalueFontPixelSize": 110,
    "temperatureValuecontainerUnitcontainerUnitlabelFontPixelSize": 40,
    "temperatureValuecontainerPrecisioncontainerPrecisionalabelFontPixelSize": 25,

    "temperatureAveragecontainerLeftmargin": 20,
    "temperatureAveragecontainerAveragelabelFontPixelSize": 30,
    "temperatureAveragecontainerAverageValueFontPixelSize": 45,
    "temperatureStatsheaderHeight": 70,
    "temperatureStatsheaderStatsiconIconSize":25,
    "temperatureStatsheaderStatstextFontPixelSize": 30,
    "temperatureStatsheaderStatstextLeftMargin":30,
    "temperatureAveragecontainerWidth": 700,

    "temperatureStatsheaderPeriodcomboWidth": 300,

    //device/Device.qml
    "deviceDevicepageMarginSize": 45,
    "deviceDevicepagePaddingSize": 40,
    "deviceDevicepageBottomMarginSize": 68,
    "deviceDevicepageContentcanvasRadius": 30,
    "deviceDevicepageContentcanvasIconcontainerWidth": 80,
    "deviceDevicepageContentcanvasStatuscontainerHeight": 80,
    "deviceDevicepageContentcanvasEnablecontainerHeight": 80,
    "deviceDevicepageContentcanvascontentcontainerTechcontainerHeight": 40,
    "deviceDevicepageContentcanvascontentcontainerTechIconIconSize": 20,
    "deviceDevicepageContentcanvascontentcontainerTechlabelFontPixelSize": 20,
    "deviceDevicepageContentcanvascontentcontainerTechlabelLeftMargin": 20,
    "deviceDevicepageContentcanvasContentcontainerDescriptioncontainerHeight": 40,
    "deviceDevicepageContentcanvasdescriptioncontainerDescriptionIconIconSize": 20,
    "deviceDevicepageContentcanvasdescriptioncontainerDescriptionlabelFontPixelSize": 20,
    "deviceDevicepageContentcanvasdescriptioncontainerDescriptionlabelLeftMargin": 20,
    "deviceDevicepageContentcanvasdescriptioncontainerDescriptionvalueHeight": 35,
    "deviceDevicepageContentcanvascontentcontainerTechinfocolumnRowheight": 60,
    "deviceDevicepageContentcanvascontentcontainerTechinfocolumnRowvalueLeftMargin":40,
    "deviceDevicepageContentcanvascontentcontainerTechinfocolumnRowTitleWidth": 70,
    "deviceDevicepageContentcanvascontentcontainerTechinfocolumnRowTitleFontPixelSize": 25,
    "deviceDevicepageContentcanvasScenarioandlogscontainerTabsContainerHeight": 65,
    "deviceDevicepageContentcanvasScenarioandlogscontainerTabsContainerWidth": 800,


    "deviceDevicepageInfocontainerHeaderWidth": 350,

    "deviceInfoHeaderLabelFontPointSize": 30,

    "deviceListItemListItemHeight": 130,
    "deviceListItemIconFrameWidth": 70,
    "deviceListItemIconFrameHeight": 70,
    "deviceListItemIconFrameRadius": 10,
    "deviceListItemIconFrameIconSize": 22,
    "deviceListItemGetNameFontPointSize": 25,
    "contentcontainerTechIconIconSize": 25,
    "contentcontainerTechlabelFontPixelSize": 19,

    "devicesFiltersHeight":60,



    "platformPlatformInfoInformationsNamecontainerHeight": 100,
    "platformAdvancedHeight": 60,
    "platformAdvancedIdrowHeight": 25,
    "platformAdvancedAnimationToHeight": 200,
    "platformAdvancedIdrowTopMargin": 20,
    "platformAdvancedIdrowFontPointSize": 16,
    "platformAdvancedAdvancediconIconSize": 20,
    "platformAdvancedAdvancediconMargin": 30,
    "platformAdvancedAdvancedtextFontPointSize": 20,
    "platformAdvancedAdvancedtextLeftmargin": 20,
    "platformPlatformInfoInformationsNamecontainerEditbuttonIconSize": 30,
    "platformPlatformInfoInformationsNametextboxHeight": 50,
    "platformEnableContainerHeight": 60,
    "roomContainerRoomTextBoxHeight": 45,

    "platformListitemPlatformNameTextFontPointSize": 35,
    "platformListitemPlatformUpdateTextFontPointSize": 22,

    "platformsPlatformlistMarginSize": 45,
    "platformsFiltersHeight": 70,
    "platformsRectplatformsPlatformsColumnItemcontainerHeight": 150,
    "platformsFiltersSearchBoxIconSize": 15,
    "platformsFiltersSearchBoxRightmargin": 15,
    "platformsRectplatformsPlatformsHeaderHeight": 35,
    "platformsRectplatformsPlatformsHeaderTextFontPointSize": 15,
    "platformsRectplatformsPlatformsHeaderTextLeftMargin": 15,

    "recommandationsRecommandationsHeight": 200,
    "recommandationsRecommandationsRowcontainerFontPointSize": 20,
    "recommandationsButtonsWidth": 700,
    "recommandationsAcceptButtonHeight": 120,
    "recommandationsAcceptButtonWidth": 300,
    "recommandationsAcceptButtonRightMargin": 30,

    "scenarioFootercontainerHeight":60,

    "scenariosNoscenarioFontPointSize": 45,
    "scenariosScenariocontainerScenarioHeaderHeight": 100,
    "scenariosScenariocontainerScenarioHeaderScHeaderIcon": 40,
    "scenariosScenariocontainerScenarioHeaderFontPointSize": 30,
    "scenariosScenariocontainerScenarioHeaderLeftMargin": 40,
    "scenarioCurrentscenarioAnchorstopmargin": 200,
    "scenariosScenarioeditheaderHeight": 80,
    "scenariosCreatescenariobuttonHeight": 50,
    "scenariosCreatescenariobuttonWidth": 500,
    "scenariosCreatescenariobuttonRadius": 10,

    "settingsSettingscontainerNinjaServerUrlBox": 60,
    "settingsSettingscontainerNinjaTokenBox": 60,
    "settingsSettingscontainerSyncButtonTopmargin": 30,


    "UCarouselRowSpacing": 70,
    "UCarouselListviewSpacing": 40,
    "UCarouselUButtonChevronLeftWidth": 60,
    "UCarouselUButtonChevronLeftHeight": 60,
    "UCarouselListviewWidht1": 5,
    "UCarouselListviewWidht2": 5,
    "UCarouselListviewHeight": 90,
    "UCarouselListviewRectangleWidth": 30,
    "UCarouselListviewRectangleHeight": 30,
    "UCarouselListviewUFontawesomeIconSIze": 25,
    "UCarouselUButtonChevronRightWidth": 60,
    "UCarouselUButtonChevronRightHeight": 60,

    "USaveCancelSaveCancelHeight": 80
}
