include( ../uCtrl.pri )

# Add more folders to ship with the application, here
folder_01.source = qml/uCtrlDesktopQml
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

QT += network

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

INCLUDEPATH += ../uCtrlCore/

# Common stuff
SOURCES += \
    main.cpp \
    Network/bonjourservicebrowser.cpp \
    Network/bonjourserviceresolver.cpp \
    Models/Task/utaskmodel.cpp \
    Models/Scenario/uscenariomodel.cpp \
    Models/Device/udevicemodel.cpp

HEADERS += \
    Network/bonjourrecord.h \
    Network/bonjourservicebrowser.h \
    Network/bonjourserviceresolver.h \
    Models/Task/utaskmodel.h \
    Models/Scenario/uscenariomodel.h \
    Models/Device/udevicemodel.h

INCLUDEPATH += \
    qml/uCtrlDesktopQml/

RESOURCES += \
    Resources.qrc

CONFIG(debug, debug|release) {
    uCtrlCore_QMAKE_CMD = qmake $$SRC_DIR/uCtrlCore/uCtrlCore.pro -r CONFIG+=debug CONFIG-=release\
                          CONFIG+=x86_64 CONFIG+=declarative_debug CONFIG+=qml_debug
} else {
    uCtrlCore_QMAKE_CMD = qmake $$SRC_DIR/uCtrlCore/uCtrlCore.pro -r CONFIG+=x86_64
}

win32 { 
    uCtrlCore_DIR = $$OUT_PWD/../uCtrlCore
    uCtrlCore_CMD = IF NOT EXIST $$uCtrlCore_DIR MKDIR $$uCtrlCore_DIR && cd $$OUT_PWD/../uCtrlCore && $$uCtrlCore_QMAKE_CMD && mingw32-make
    uCtrlCore_CMD = $$replace(uCtrlCore_CMD, /, \\)
    CONFIG(debug, debug|release) {
        LIBS += -L$$OUT_PWD/../uCtrlCore/debug -luCtrlCore
        uCtrlCore_TARGET = $$OUT_PWD/../uCtrlCore/debug/libuCtrlCore.a
    } else {
        LIBS += -L$$OUT_PWD/../uCtrlCore/release -luCtrlCore
        uCtrlCore_TARGET = $$OUT_PWD/../uCtrlCore/release/libuCtrlCore.a
    }
} else {
    uCtrlCore_CMD = mkdir -p $$OUT_PWD/../uCtrlCore && cd $$OUT_PWD/../uCtrlCore && $$uCtrlCore_QMAKE_CMD && make
    LIBS += -L$$OUT_PWD/../uCtrlCore/ -luCtrlCore
    uCtrlCore_TARGET = $$OUT_PWD/../uCtrlCore/libuCtrlCore.a
}

uCtrlCore.target     = $$uCtrlCore_TARGET
uCtrlCore.depends    = $$SRC_DIR/uCtrlCore/uCtrlCore.pro
uCtrlCore.commands   = $$uCtrlCore_CMD

PRE_TARGETDEPS += $$uCtrlCore_TARGET
QMAKE_EXTRA_TARGETS += uCtrlCore
INCLUDEPATH += $$PWD/../uCtrlCore
DEPENDPATH += $$PWD/../uCtrlCore

!mac:LIBS += -ldns_sd

win32 {
    LIBS += -L$$PWD/Network/lib/ -ldnssd
    INCLUDEPATH += $$PWD/Network/lib
    DEPENDPATH += $$PWD/Network/lib
}

OTHER_FILES += \
    qml/uCtrlDesktopQml/UI/UPath.qml \
    qml/uCtrlDesktopQml/UI/UComboBox.qml
