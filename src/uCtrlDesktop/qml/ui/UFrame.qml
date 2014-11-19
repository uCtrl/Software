import QtQuick 2.0
import QtQuick.Controls 1.0
import "UColors.js" as Colors


ScrollView {
    property bool requiredModel: false
    property var model: null
    property int frameMarginSize: 16

    contentItem: Rectangle {
        color: Colors.uTransparent
    }

   signal bind(variant newModel)
   onBind: {
       if (requiredModel) {
           model = newModel
           refresh(model)
       }
   }

   // FOLLOWING FUNCTIONS MAY BE OVERRIDEN BY FRAME LEAF
   function refresh() {
   }
}
