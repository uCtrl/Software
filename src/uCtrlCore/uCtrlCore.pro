QT       += network

QT       -= gui

TARGET = uCtrlCore
TEMPLATE = lib
CONFIG += staticlib

SOURCES += \
    uplatform.cpp \
    usystem.cpp \
    Device/udevice.cpp \
    Device/udevicebuilder.cpp \
    Device/udeviceinfo.cpp \
    Device/udevicestateinfo.cpp \
    Conditions/ucondition.cpp \
    Conditions/uconditionbuilder.cpp \
    Conditions/uconditiondate.cpp \
    Conditions/uconditionday.cpp \
    Conditions/uconditiontime.cpp \
    Scenario/uscenario.cpp \
    Scenario/uscenariobuilder.cpp \
    Scenario/uscenariobuilderobserver.cpp \
    Serialization/json/json.cpp \
    Tasks/utask.cpp \
    Tasks/utaskbuilder.cpp \
    Tasks/utaskbuilderobserver.cpp \
    Utility/uniqueidgenerator.cpp \
    Conditions/uconditionbuilderobserver.cpp \
    Device/udeviceinfobuilder.cpp\
    Conditions/udate.cpp \
    Conditions/utime.cpp


HEADERS += \
    uplatform.h \
    usystem.h \
    Device/udevice.h \
    Device/udevicebuilder.h \
    Device/udeviceinfo.h \
    Device/udevicestateinfo.h \
    Conditions/ucondition.h \
    Conditions/uconditionbuilder.h \
    Conditions/uconditiondate.h \
    Conditions/uconditionday.h \
    Conditions/uconditiontime.h \
    Scenario/uscenario.h \
    Scenario/uscenariobuilder.h \
    Scenario/uscenariobuilderobserver.h \
    Serialization/JsonMacros.h \
    Serialization/json/json.h \
    Tasks/utask.h \
    Tasks/utaskbuilder.h \
    Tasks/utaskbuilderobserver.h \
    Utility/uniqueidgenerator.h \
    Conditions/uconditionbuilderobserver.h \
    Device/udeviceinfobuilder.h \
    Conditions/udate.h \
    Conditions/utime.h