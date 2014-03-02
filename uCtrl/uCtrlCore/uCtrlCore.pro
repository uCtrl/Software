#-------------------------------------------------
#
# Project created by QtCreator 2014-02-19T13:24:23
#
#-------------------------------------------------

QT       -= core gui

TARGET = uCtrlCore
TEMPLATE = lib

DEFINES += UCTRLCORE_LIBRARY

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

unix {
    target.path = /usr/lib
    INSTALLS += target
}
