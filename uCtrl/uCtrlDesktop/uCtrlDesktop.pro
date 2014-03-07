# Add more folders to ship with the application, here
folder_01.source = qml/uCtrlDesktopQml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

QT += network

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

# Common stuff
SOURCES += \
    main.cpp \
    Network/bonjourservicebrowser.cpp \
    Network/bonjourserviceresolver.cpp \
    Models/Task/utaskmodel.cpp \
    Models/Scenario/uscenariomodel.cpp \
    ../uCtrlCore/Conditions/uconditionbuilder.cpp \
    ../uCtrlCore/Conditions/uconditionday.cpp \
    ../uCtrlCore/Scenario/uscenariobuilder.cpp \
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
    ../uCtrlCore/Device/udevicestateinfo.cpp \
    ../uCtrlCore/Utility/uniqueidgenerator.cpp \
    ../uCtrlCore/Scenario/uscenariobuilderobserver.cpp \
    ../uCtrlCore/Tasks/utaskbuilderobserver.cpp \
    ../uCtrlCore/Device/udevicebuilder.cpp \
    ../uCtrlCore/Tasks/utaskbuilder.cpp

HEADERS += \
    Network/bonjourrecord.h \
    Network/bonjourservicebrowser.h \
    Network/bonjourserviceresolver.h \
    Models/Task/utaskmodel.h \
    Models/Scenario/uscenariomodel.h \
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
    ../uCtrlCore/Conditions/uconditionbuilder.h \
    ../uCtrlCore/Conditions/uconditionday.h \
    ../uCtrlCore/Scenario/uscenariobuilder.h \
    ../uCtrlCore/Serialization/JsonMacros.h \
    ../uCtrlCore/Device/udevicebuilder.h \
    ../uCtrlCore/Utility/uniqueidgenerator.h \
    ../uCtrlCore/Scenario/uscenariobuilderobserver.h \
    ../uCtrlCore/Tasks/utaskbuilderobserver.h \
    ../uCtrlCore/Tasks/utaskbuilder.h

INCLUDEPATH += \
    qml/uCtrlDesktopQml/

RESOURCES += \
    Resources.qrc

!mac:LIBS += -ldns_sd

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/Network/lib/ -ldnss
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/Network/lib/ -ldnssd
win32:INCLUDEPATH += $$PWD/Network/lib
win32:DEPENDPATH += $$PWD/Network/lib
