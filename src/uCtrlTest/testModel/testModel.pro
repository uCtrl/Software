QT     += testlib network

QT     -= gui

TARGET  = testmodel
CONFIG += console
CONFIG -= app_bundle
CONFIG += staticlib c++11

TEMPLATE = app

SOURCES +=

HEADERS += \
    testmodel.h

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../../uCtrlCore/release/ -luCtrlCore
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../../uCtrlCore/debug/ -luCtrlCore
else:unix: LIBS += -L$$OUT_PWD/../../uCtrlCore/ -luCtrlCore

INCLUDEPATH += $$PWD/../../uCtrlCore
DEPENDPATH += $$PWD/../../uCtrlCore

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../uCtrlCore/release/libuCtrlCore.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../uCtrlCore/debug/libuCtrlCore.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../uCtrlCore/release/uCtrlCore.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../../uCtrlCore/debug/uCtrlCore.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../../uCtrlCore/libuCtrlCore.a
