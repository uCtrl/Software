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
	LIBS += -L$$PWD/../uCtrlDesktop/Network/lib -ldnssd
	INCLUDEPATH += $$PWD/../uCtrlDesktop/Network/lib
	DEPENDPATH += $$PWD/../uCtrlDesktop/Network/lib	
}
