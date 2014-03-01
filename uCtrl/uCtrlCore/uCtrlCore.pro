#-------------------------------------------------
#
# Project created by QtCreator 2014-02-19T13:24:23
#
#-------------------------------------------------

QT       += core
QT       -= gui

TARGET = uCtrlCore
TEMPLATE = lib

DEFINES += UCTRLCORE_LIBRARY

SOURCES += \
    ../uCtrlCore/*.cpp \
    ../uCtrlCore/Device/*.cpp \
    ../uCtrlCore/Tasks/*.cpp \
    ../uCtrlCore/Conditions/*.cpp \
    ../uCtrlCore/Scenario/*.cpp \
    ../uCtrlCore/Serialization/*.cpp \

HEADERS += \
    ../uCtrlCore/*.h \
    ../uCtrlCore/Device/*.h \
    ../uCtrlCore/Tasks/*.h \
    ../uCtrlCore/Conditions/*.h \
    ../uCtrlCore/Scenario/*.h \
    ../uCtrlCore/Serialization/*.h \

unix {
    target.path = /usr/lib
    INSTALLS += target
}
