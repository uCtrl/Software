QT       += network

QT       -= gui

TARGET = uCtrlCore
TEMPLATE = lib
CONFIG += staticlib

SOURCES += \
    uplatform.cpp \
    usystem.cpp \
    Device/udevice.cpp \
    Device/udeviceinfo.cpp \
    Device/udevicestateinfo.cpp \
    Conditions/ucondition.cpp \
    Conditions/uconditiondate.cpp \
    Conditions/uconditionday.cpp \
    Conditions/uconditiontime.cpp \
    Scenario/uscenario.cpp \
    Serialization/json/json.cpp \
    Tasks/utask.cpp \
    Utility/uniqueidgenerator.cpp \
    Conditions/udate.cpp \
    Conditions/utime.cpp


HEADERS += \
    uplatform.h \
    usystem.h \
    Device/udevice.h \
    Device/udeviceinfo.h \
    Device/udevicestateinfo.h \
    Conditions/ucondition.h \
    Conditions/uconditiondate.h \
    Conditions/uconditionday.h \
    Conditions/uconditiontime.h \
    Scenario/uscenario.h \
    Serialization/JsonMacros.h \
    Serialization/json/json.h \
    Tasks/utask.h \
    Utility/uniqueidgenerator.h \
    Conditions/udate.h \
    Conditions/utime.h