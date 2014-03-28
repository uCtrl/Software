QT       += network

QT       -= gui

TARGET = uCtrlCore
TEMPLATE = lib
CONFIG += staticlib

SOURCES += \
    Platform/uplatform.cpp \
    Device/udevice.cpp \
    Conditions/ucondition.cpp \
    Scenario/uscenario.cpp \
    Tasks/utask.cpp \
    Utility/uniqueidgenerator.cpp \
    System/usystem.cpp \
    Serialization/jsonserializer.cpp

HEADERS += \
    Platform/uplatform.h \
    System/usystem.h \
    Device/udevice.h \
    Conditions/ucondition.h \
    Scenario/uscenario.h \
    Tasks/utask.h \
    Utility/uniqueidgenerator.h \
    Serialization/jsonserializable.h \
    Serialization/jsonserializer.h
