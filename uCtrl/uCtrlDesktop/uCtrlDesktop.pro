# Add more folders to ship with the application, here
folder_01.source = qml/uCtrlDesktopQml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    ../uCtrlCore/Tasks/utasksbuilder.cpp \
    ../uCtrlCore/Conditions/uconditionbuilder.cpp \
    ../uCtrlCore/Conditions/uconditionday.cpp \
    ../uCtrlCore/Scenario/uscenariobuilder.cpp

# Installation path
# target.path =

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

# Common stuff
SOURCES += \
    ../uCtrlCore/usystem.cpp \
    ../uCtrlCore/uplatform.cpp \
    ../uCtrlCore/Device/udevice.cpp \
    ../uCtrlCore/Device/udevicesummary.cpp \
    ../uCtrlCore/Device/udeviceinfo.cpp \
    ../uCtrlCore/Tasks/utask.cpp \
    ../uCtrlCore/Conditions/ucondition.cpp \
    ../uCtrlCore/Conditions/uconditiontime.cpp \
    ../uCtrlCore/Conditions/uconditiondate.cpp \
    ../uCtrlCore/Scenario/uscenario.cpp \
    ../uCtrlCore/Serialization/json/json.cpp \
    ../uCtrlCore/Device/udevicestateinfo.cpp

HEADERS += \
    ../uCtrlCore/usystem.h\
    ../uCtrlCore/uctrlcore_global.h \
    ../uCtrlCore/uplatform.h \
    ../uCtrlCore/Device/udevice.h \
    ../uCtrlCore/Device/udevicesummary.h \
    ../uCtrlCore/Device/udeviceinfo.h \
    ../uCtrlCore/Tasks/utask.h \
    ../uCtrlCore/Conditions/ucondition.h \
    ../uCtrlCore/Conditions/uconditiontime.h \
    ../uCtrlCore/Conditions/uconditiondate.h \
    ../uCtrlCore/Scenario/uscenario.h \
    ../uCtrlCore/Serialization/json/json.h \
    ../uCtrlCore/Device/udevicestateinfo.h \
    ../uCtrlCore/Tasks/utasksbuilder.h \
    ../uCtrlCore/Conditions/uconditionbuilder.h \
    ../uCtrlCore/Conditions/uconditionday.h \
    ../uCtrlCore/Scenario/uscenariobuilder.h \
    ../uCtrlCore/Serialization/JsonMacros.h

# Interface-specific stuff
SOURCES += \
    Models/Task/utaskmodel.cpp \
    Models/Scenario/uscenariomodel.cpp \

HEADERS += \
    Models/Task/utaskmodel.h \
    Models/Scenario/uscenariomodel.h \

INCLUDEPATH += \
    qml/uCtrlDesktopQml/

RESOURCES += \
    Resources.qrc

