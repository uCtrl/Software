import QtQuick 2.0
import QtQuick.Controls 1.0

ScrollView {
    property bool requiredModel: false
    property var model: null

    contentItem: Rectangle {
        color: _colors.uTransparent
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
