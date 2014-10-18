QT       += network

TARGET = uCtrlCore
TEMPLATE = lib
CONFIG += staticlib c++11

SOURCES += \
    Serialization/jsonserializer.cpp \
    Condition/ucondition.cpp \
    Device/udevice.cpp \
    Models/listmodel.cpp \
    Models/nestedlistmodel.cpp \
    Platform/uplatform.cpp \
    Scenario/uscenario.cpp \
    Task/utask.cpp \
    Models/listitem.cpp \
    Platform/uplatformsmodel.cpp \
    Device/udevicesmodel.cpp \
    Scenario/uscenariosmodel.cpp \
    Task/utasksmodel.cpp \
    Condition/uconditionsmodel.cpp


HEADERS += \
    Serialization/jsonserializable.h \
    Serialization/jsonserializer.h \
    Serialization/jsonwritable.h \
    Serialization/jsonreadable.h \
    Utility/oshandler.h \
    Condition/ucondition.h \
    Device/udevice.h \
    Models/listitem.h \
    Models/listmodel.h \
    Models/nestedlistitem.h \
    Models/nestedlistmodel.h \
    Platform/uplatform.h \
    Scenario/uscenario.h \
    Task/utask.h \
    Platform/uplatformsmodel.h \
    Device/udevicesmodel.h \
    Scenario/uscenariosmodel.h \
    Task/utasksmodel.h \
    Condition/uconditionsmodel.h

DEFINES += PROJECT_PATH=\"\\\"$$PWD/../\\\"\"
