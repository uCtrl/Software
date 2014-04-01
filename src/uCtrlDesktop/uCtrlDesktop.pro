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
    Network/bonjourserviceresolver.cpp

HEADERS += \
    Network/bonjourrecord.h \
    Network/bonjourservicebrowser.h \
    Network/bonjourserviceresolver.h

INCLUDEPATH += \
    qml/uCtrlDesktopQml/

RESOURCES += \
    Resources.qrc

# Translations
TRANSLATIONS += \
    Languages/uctrl_en.ts \
    Languages/uctrl_fr.ts

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
    LIBS += -L$$PWD/../libs/bonjour-sdk -ldnssd
    INCLUDEPATH += $$PWD/../libs/bonjour-sdk 
    DEPENDPATH += $$PWD/../libs/bonjour-sdk 
}

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
    qml/uCtrlDesktopQml/UI/UPath.qml \
    Languages/uctrl_en.ts \
    Languages/uctrl_fr.ts \
    qml/uCtrlDesktopQml/UI/UComboBox.qml \
    qml/uCtrlDesktopQml/Scenario/UTaskWidget.qml \
    qml/uCtrlDesktopQml/UI/UFontAwesome.qml \
    qml/uCtrlDesktopQml/Navbar/UNavbar.qml \
    qml/uCtrlDesktopQml/UI/UToolTip.qml \
    qml/uCtrlDesktopQml/UI/ULabel/Default.qml \
    qml/uCtrlDesktopQml/UI/ULabel/Heading1.qml \
    qml/uCtrlDesktopQml/UI/ULabel/Heading2.qml \
    qml/uCtrlDesktopQml/UI/ULabel/Heading3.qml \
    qml/uCtrlDesktopQml/UI/ULabel/Heading4.qml \
    qml/uCtrlDesktopQml/UI/ULabel/Heading5.qml \
    qml/uCtrlDesktopQml/UI/ULabel/TooltipText.qml \
    qml/uCtrlDesktopQml/UI/UComboBoxItem.qml \
    qml/uCtrlDesktopQml/UI/USeparator.qml \
    qml/uCtrlDesktopQml/UI/UComboBoxItemContainer.qml \
    qml/uCtrlDesktopQml/UI/ULabel/ComboBoxItemText.qml
