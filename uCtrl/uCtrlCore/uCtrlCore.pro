#-------------------------------------------------
#
# Project created by QtCreator 2014-02-19T13:24:23
#
#-------------------------------------------------

QT += core
QT -= gui

TARGET = uCtrlCore
TEMPLATE = lib

DEFINES += UCTRLCORE_LIBRARY

SOURCES += usystem.cpp \
    uplatform.cpp \
    Device/udevice.cpp \
    Device/udevicesummary.cpp \
    Device/udeviceinfo.cpp \
    Tasks/utask.cpp \
    Conditions/ucondition.cpp \
    Conditions/uconditiontime.cpp \
    Conditions/uconditiondate.cpp \
    Scenario/uscenario.cpp \
    Serialization/json/json.cpp \
    Device/udevicestateinfo.cpp \
    Scenario/uscenariobuilder.cpp \
    Conditions/uconditionbuilder.cpp \
    Conditions/uconditionday.cpp \
    Utility/uniqueidgenerator.cpp \
    Tasks/utaskbuilder.cpp \
    Tasks/utaskbuilderobserver.cpp \
    Scenario/uscenariobuilderobserver.cpp \
    Device/udevicebuilder.cpp

HEADERS += usystem.h\
        uctrlcore_global.h \
    uplatform.h \
    Device/udevice.h \
    Device/udevicesummary.h \
    Device/udeviceinfo.h \
    Tasks/utask.h \
    Conditions/ucondition.h \
    Conditions/uconditiontime.h \
    Conditions/uconditiondate.h \
    Scenario/uscenario.h \
    Serialization/json/json.h \
    Device/udevicestateinfo.h \
    Scenario/uscenariobuilder.h \
    Conditions/uconditionbuilder.h \
    Conditions/uconditionday.h \
    Utility/uniqueidgenerator.h \
    Tasks/utaskbuilder.h \
    Tasks/utaskbuilderobserver.h \
    Serialization/JsonMacros.h \
    Scenario/uscenariobuilderobserver.h \
    Device/udevicebuilder.h

unix {
    target.path = /usr/lib
    INSTALLS += target
}
