# Add more folders to ship with the application, here
folder_01.source = qml/uCtrlDesktopQml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()


SOURCES += \
    ../../common/usystem.cpp \
    ../../common/uplatform.cpp \
    ../../common/Device/udevice.cpp \
    ../../common/Device/udevicesummary.cpp \
    ../../common/Device/udeviceinfo.cpp \
    ../../common/Tasks/utask.cpp \
    ../../common/Conditions/ucondition.cpp \
    ../../common/Conditions/uconditiontime.cpp \
    ../../common/Conditions/uconditiondate.cpp \
    ../../common/Scenario/uscenario.cpp \
    ../../common/Serialization/json/json.cpp \
    ../../common/Device/udevicestateinfo.cpp

HEADERS += \
    ../../common/usystem.h\
    ../../common/uctrlcore_global.h \
    ../../common/uplatform.h \
    ../../common/Device/udevice.h \
    ../../common/Device/udevicesummary.h \
    ../../common/Device/udeviceinfo.h \
    ../../common/Tasks/utask.h \
    ../../common/Conditions/ucondition.h \
    ../../common/Conditions/uconditiontime.h \
    ../../common/Conditions/uconditiondate.h \
    ../../common/Scenario/uscenario.h \
    ../../common/Serialization/json/json.h \
    ../../common/Device/udevicestateinfo.h

OTHER_FILES += \
    qml/uCtrlDesktopQml/UHeaderBarWidget.qml \
    qml/uCtrlDesktopQml/UTitleLabelWidget.qml \
    qml/uCtrlDesktopQml/UConfigWidget.qml \
    qml/uCtrlDesktopQml/UImageWidget.qml \
    Images/uCtrl-Icon.png

RESOURCES += \
    Resources.qrc
