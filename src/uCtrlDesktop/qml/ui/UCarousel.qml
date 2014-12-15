import QtQuick 2.0

import "UColors.js" as Colors

Rectangle {
    property var carouselIcons: []
    property var carouselItems: []
    property int currentIndex: 0

    signal changeItem(var item)

    function displayItem(index)
    {
        for(var i = 0; i < data.length; i++)
        {
            if(index === i)
            {
                changeItem(carouselItems[i])
                carouselItems[i].x = 0;
            }
            else
                carouselItems[i].x = carouselItems[i].width
        }
    }

    function exitItem(index, direction)
    {
        if(direction === 1)
        {
            carouselItems[index].exitRight();
        }
        else
        {
            carouselItems[index].exitLeft();
        }
    }

    function enterItem(index, direction)
    {
        changeItem(carouselItems[index])
        if(direction === 1)
        {
            carouselItems[index].enterLeft();
        }
        else
        {
            carouselItems[index].enterRight();
        }
    }

    anchors.fill: parent

    color: Colors.uTransparent

    Component.onCompleted: {
        displayItem(currentIndex)
    }

    Timer
    {
        id: autoSwitchTimer
        interval: 10000
        repeat: true
        running: true
        onTriggered: moveForward()
    }

    Row{
        anchors.horizontalCenter: parent.horizontalCenter

        height: parent.height
        spacing: (resourceLoader.loadResource("UCarouselRowSpacing"))

        UButton
        {
            width: 30
            height: 30

            buttonColor: Colors.uTransparent
            buttonHoveredColor: Colors.uTransparent
            buttonTextColor : Colors.uGrey
            anchors.verticalCenter: parent.verticalCenter

            iconId: "ChevronLeft"
            onClicked: {
                moveBackwards()
                autoSwitchTimer.stop()
            }
        }

        ListView
        {
            spacing: (resourceLoader.loadResource("UCarouselListviewSpacing"))
            orientation: ListView.Horizontal
            width: carouselIcons.length * 30 + (carouselIcons.length - 1) * 10
            height: 60
            model: carouselIcons
            interactive: false
            anchors.verticalCenter: parent.verticalCenter
            delegate: Rectangle {
                width: (resourceLoader.loadResource("UCarouselListviewRectangleWidth"))
                height: (resourceLoader.loadResource("UCarouselListviewRectangleHeight"))
                anchors.verticalCenter: parent.verticalCenter
                UFontAwesome
                {
                    iconId: carouselIcons[index]
                    iconColor: currentIndex === index ? Colors.uGreen : Colors.uGrey
                    iconSize: 30
                    anchors.centerIn: parent
                }
            }
        }

        UButton
        {
            width: 30
            height: 30

            buttonColor: Colors.uTransparent
            buttonHoveredColor: Colors.uTransparent
            buttonTextColor : Colors.uGrey
            anchors.verticalCenter: parent.verticalCenter
            iconId: "ChevronRight"
            onClicked: {
                moveForward()
                autoSwitchTimer.stop()
            }
        }
    }

    function changeTo(index)
    {
        if(index === currentIndex)
            return

        exitItem(currentIndex, index < currentIndex ? 1 : -1)
        enterItem(index, index < currentIndex ? 1 : -1)
        currentIndex = index
    }

    function moveForward()
    {
        var newIndex = currentIndex + 1
        if(newIndex >= carouselIcons.length)
            newIndex = 0
        exitItem(currentIndex, -1)
        enterItem(newIndex, -1)
        currentIndex = newIndex
    }

    function moveBackwards()
    {
        var newIndex = currentIndex - 1
        if(newIndex < 0)
            newIndex = carouselIcons.length - 1
        exitItem(currentIndex, 1)
        enterItem(newIndex, 1)
        currentIndex = newIndex
    }

}
