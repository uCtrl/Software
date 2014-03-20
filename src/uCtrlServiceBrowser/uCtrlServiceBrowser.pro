QT += network widgets

HEADERS =  \
    client.h \
    ../uCtrlDesktop/Network/bonjourrecord.h \
    ../uCtrlDesktop/Network/bonjourservicebrowser.h \
    ../uCtrlDesktop/Network/bonjourserviceresolver.h

SOURCES = \
    client.cpp \
    main.cpp \
    ../uCtrlDesktop/Network/bonjourservicebrowser.cpp \
    ../uCtrlDesktop/Network/bonjourserviceresolver.cpp

!mac:LIBS += -ldns_sd

win32 {
        LIBS += -L$$PWD/../libs/bonjour-sdk -ldnssd
        INCLUDEPATH += $$PWD/../libs/bonjour-sdk
        DEPENDPATH += $$PWD/../libs/bonjour-sdk
}
