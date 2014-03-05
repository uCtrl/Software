# Add more folders to ship with the application, here
folder_01.source = qml/uCtrlDesktopQml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

QT += network

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += \
    main.cpp \
    Network/bonjourservicebrowser.cpp \
    Network/bonjourserviceresolver.cpp \
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
    Network/bonjourrecord.h \
    Network/bonjourservicebrowser.h \
    Network/bonjourserviceresolver.h \
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


# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()


#SOURCES += \
#    ../uCtrlCore/*.cpp \
#    ../uCtrlCore/Device/*.cpp \
#    ../uCtrlCore/Tasks/*.cpp \
#    ../uCtrlCore/Conditions/*.cpp \
#    ../uCtrlCore/Scenario/*.cpp \
#    ../uCtrlCore/Serialization/*.cpp \

#HEADERS += \
#    ../uCtrlCore/*.h \
#    ../uCtrlCore/Device/*.h \
#    ../uCtrlCore/Tasks/*.h \
#    ../uCtrlCore/Conditions/*.h \
#    ../uCtrlCore/Scenario/*.h \
#    ../uCtrlCore/Serialization/*.h \

INCLUDEPATH += \
    qml/uCtrlDesktopQml/

RESOURCES += \
    Resources.qrc

!mac:LIBS += -ldns_sd

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/Network/lib/ -ldnss
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/Network/lib/ -ldnssd
win32:INCLUDEPATH += $$PWD/Network/lib
win32:DEPENDPATH += $$PWD/Network/lib
