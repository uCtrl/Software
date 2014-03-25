QT       += network

QT       -= gui

TARGET = uCtrlCore
TEMPLATE = lib
CONFIG += staticlib

SOURCES += \
    Platform/uplatform.cpp \
    Device/udevice.cpp \
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
    Conditions/utime.cpp \
    System/usystem.cpp

HEADERS += \
    Platform/uplatform.h \
    usystem.h \
    Device/udevice.h \
    Device/udevicestateinfo.h \
    Conditions/ucondition.h \
    Conditions/uconditiondate.h \
    Conditions/uconditionday.h \
    Conditions/uconditiontime.h \
    Scenario/uscenario.h \
    Serialization/JsonMacros.h \
    Serialization/json/json.h \
    Tasks/utask.h \
    Tasks/utaskbuilder.h \
    Utility/uniqueidgenerator.h \
    Conditions/udate.h \
    Conditions/utime.h \
    System/usystem.h
