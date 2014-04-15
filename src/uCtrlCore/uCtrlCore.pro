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
    Communication/ucommunicationhandler.cpp \
    Communication/Responses/getplatformresponse.cpp \
    Communication/Requests/getplatformrequest.cpp \
    Conditions/uconditiontime.cpp \
    Conditions/uconditionweekday.cpp \
    Conditions/uconditiondevice.cpp \
    Device/udevicelist.cpp


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
    Communication/ucommunicationhandler.h \
    Serialization/jsonwritable.h \
    Serialization/jsonreadable.h \
    Communication/uemessagetype.h \
    Communication/Responses/getplatformresponse.h \
    Communication/Requests/getplatformrequest.h \
    Communication/Responses/uresponse.h \
    Communication/Requests/urequest.h \
    Conditions/uconditiontime.h \
    Conditions/uconditionweekday.h \
    Conditions/uconditiondevice.h \
    Device/udevicelist.h