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

win32:CONFIG(release, debug|release): LIBS += -L$$OUT_PWD/../uCtrlCore/release/ -luCtrlCore
else:win32:CONFIG(debug, debug|release): LIBS += -L$$OUT_PWD/../uCtrlCore/debug/ -luCtrlCore
else:unix: LIBS += -L$$OUT_PWD/../uCtrlCore/ -luCtrlCore

INCLUDEPATH += $$PWD/../uCtrlCore
DEPENDPATH += $$PWD/../uCtrlCore

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../uCtrlCore/release/libuCtrlCore.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../uCtrlCore/debug/libuCtrlCore.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../uCtrlCore/release/uCtrlCore.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$OUT_PWD/../uCtrlCore/debug/uCtrlCore.lib
else:unix: PRE_TARGETDEPS += $$OUT_PWD/../uCtrlCore/libuCtrlCore.a

!mac:LIBS += -ldns_sd

win32:CONFIG(release, debug|release): LIBS += -L$$PWD/Network/lib/ -ldnss
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/Network/lib/ -ldnssd
win32:INCLUDEPATH += $$PWD/Network/lib
win32:DEPENDPATH += $$PWD/Network/lib

OTHER_FILES += \
    qml/uCtrlDesktopQml/UI/UPath.qml
