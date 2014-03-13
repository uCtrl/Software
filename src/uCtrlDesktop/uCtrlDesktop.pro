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

debug: uCtrlCore_QMAKE_CMD    = qmake $$SRC_DIR/uCtrlCore/uCtrlCore.pro -r CONFIG+=debug \
                                CONFIG+=x86_64 CONFIG+=declarative_debug CONFIG+=qml_debug
release: uCtrlCore_QMAKE_CMD  = qmake $$SRC_DIR/uCtrlCore/uCtrlCore.pro -r CONFIG+=x86_64

uCtrlCore.target     = $$OUT_PWD/../uCtrlCore/libuCtrlCore.a
uCtrlCore.depends    = $$SRC_DIR/uCtrlCore/uCtrlCore.pro
uCtrlCore.commands   = mkdir -p $$OUT_PWD/../uCtrlCore && cd $$OUT_PWD/../uCtrlCore && $$uCtrlCore_QMAKE_CMD && make
PRE_TARGETDEPS      += $$OUT_PWD/../uCtrlCore/libuCtrlCore.a
QMAKE_EXTRA_TARGETS += uCtrlCore

LIBS += -L$$OUT_PWD/../uCtrlCore/ -luCtrlCore

INCLUDEPATH += $$PWD/../uCtrlCore
DEPENDPATH += $$PWD/../uCtrlCore

!mac:LIBS += -ldns_sd

win32 {
    LIBS += -L$$PWD/Network/lib/ -ldnssd
    INCLUDEPATH += $$PWD/Network/lib
    DEPENDPATH += $$PWD/Network/lib
}
