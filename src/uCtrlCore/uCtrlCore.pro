QT       += network

QT       -= gui

TARGET = uCtrlCore
TEMPLATE = lib
CONFIG += staticlib c++11

SOURCES += \
    Platform/uplatform.cpp \
    Device/udevice.cpp \
    Conditions/ucondition.cpp \
    Conditions/uconditiondate.cpp \
    Scenario/uscenario.cpp \
    Tasks/utask.cpp \
    Utility/uniqueidgenerator.cpp \
    System/usystem.cpp \
    Serialization/jsonserializer.cpp \
    Device/udeviceinfo.cpp \
    Communication/usocket.cpp

HEADERS += \
    Platform/uplatform.h \
    System/usystem.h \
    Device/udevice.h \
    Conditions/ucondition.h \
    Conditions/uconditiondate.h \
    Scenario/uscenario.h \
    Tasks/utask.h \
    Utility/uniqueidgenerator.h \
    Serialization/jsonserializable.h \
    Serialization/jsonserializer.h \
    Device/udeviceinfo.h \
    Communication/usocket.h
