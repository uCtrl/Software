import QtQuick 2.0

Rectangle {
    width: 360
    height: 600


    UHeaderBarWidget {
        id: headerBar
    }

    ListView {
        anchors.top: headerBar.bottom
        transformOrigin: Item.Center

        model: myConfigModel
        delegate: UConfigWidget {  }
    }

}
