#ifndef OSHANDLER_H
#define OSHANDLER_H

#include <QObject>

class OsHandler : public QObject
{
    Q_OBJECT
public:
    explicit OsHandler(QObject *parent = 0) : QObject(parent) {}

    enum OsType
    {
        Unknown = 0,
        Windows = 1,
        Mac = 2,
        Linux = 3,
        Symbian = 4,
        Maemo5 = 5,
        Maemo6 = 6,
    };

    Q_INVOKABLE int getOS()
    {
        #ifdef Q_OS_MAC
            return (int)Mac;
        #endif
        #ifdef Q_OS_WIN
            return (int)Windows;
        #endif
        #ifdef Q_OS_WIN32
            return (int)Windows;
        #endif
        #ifdef Q_OS_LINUX
            return (int)Linux;
        #endif
        #ifdef Q_WS_MAEMO_5
            return (int)Maemo5;
        #endif
        #ifdef Q_WS_MAEMO_6
            return (int)Maemo6;
        #endif
        #ifdef Q_OS_SYMBIAN
            return (int)Symbian;
        #endif
        //No OS type was found
        return (int)Unknown;
    }
signals:

public slots:

};

#endif // OSHANDLER_H
