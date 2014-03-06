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

# install
INSTALLS += target

!mac:LIBS += -ldns_sd

win32:LIBS += -L$$PWD/../uCtrlDesktop/Network/lib -ldnssd
win32:INCLUDEPATH += $$PWD/../uCtrlDesktop/Network/lib
win32:DEPENDPATH += $$PWD/../uCtrlDesktop/Network/lib
