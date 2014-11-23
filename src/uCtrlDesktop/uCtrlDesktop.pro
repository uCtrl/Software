include( ../uCtrl.pri )

QT += network
QT += multimedia
QT += websockets

CONFIG += c++11
RC_ICONS = Images/uctrl.ico
ICON = Images/uctrl.icns

#folder where the qml files are
folder_01.source = qml
#destination folder in the build directory and the install directory
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

# Please do not modify the following two lines. Required for deployment.
include(qtquick2applicationviewer/qtquick2applicationviewer.pri)
qtcAddDeployment()

# Common stuff
SOURCES += \
    main.cpp \
    Audio/uaudiorecorder.cpp \
    Voice/uvoicecontrolapi.cpp \
    Voice/uvoicecontrolresponse.cpp \
    Voice/uvoiceintent.cpp \
    Voice/uturnonofflightintent.cpp \
    Voice/usetninjaeyescolorintent.cpp \
    Voice/uturnonoffplugintent.cpp \
    Voice/uninjaapi.cpp \
    Voice/usetdimmerlights.cpp

HEADERS += \
    Audio/uaudiorecorder.h \
    Voice/uvoicecontrolapi.h \
    Voice/uvoicecontrolresponse.h \
    Voice/uvoiceintent.h \
    Voice/uturnonofflightintent.h \
    Voice/usetninjaeyescolorintent.h \
    Voice/uturnonoffplugintent.h \
    Voice/uninjaapi.h \
    Voice/usetdimmerlights.h

RESOURCES += \
    Resources.qrc

# Translations
TRANSLATIONS += \
    Languages/uctrl_en.ts \
    Languages/uctrl_fr.ts

# Rule for regenerating .qm files for translations (missing in qmake
# default ruleset, ugh!)
#
updateqm.input = TRANSLATIONS
updateqm.output = ${QMAKE_FILE_PATH}/${QMAKE_FILE_BASE}.qm
updateqm.commands = lrelease ${QMAKE_FILE_IN} -qm ${QMAKE_FILE_OUT}
updateqm.CONFIG += no_link
QMAKE_EXTRA_COMPILERS += updateqm
PRE_TARGETDEPS += compiler_updateqm_make_all

OTHER_FILES += \
    Languages/uctrl_en.ts \
    Languages/uctrl_fr.ts

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
