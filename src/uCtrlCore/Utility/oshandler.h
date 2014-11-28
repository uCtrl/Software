#ifndef OSHANDLER_H
#define OSHANDLER_H

#include <QObject>

class OsHandler : public QObject
{
    Q_OBJECT
public:
    explicit OsHandler(QObject *parent = 0) : QObject(parent) {}


    enum class OsType: int
    {
        Unknown = 0,
        Windows = 1,
        Mac = 2,
        Linux = 3,
        Symbian = 4,
        Maemo5 = 5,
        Maemo6 = 6,
        Android = 7,
    };

    Q_ENUMS (OsType)

    Q_INVOKABLE OsType getOS()
    {
        #ifdef Q_OS_MAC
            return OsType::Mac;
        #endif
        #ifdef Q_OS_WIN
            return OsType::Windows;
        #endif
        #ifdef Q_OS_WIN32
            return OsType::Windows;
        #endif
        #ifdef Q_WS_MAEMO_5
            return OsType::Maemo5;
        #endif
        #ifdef Q_WS_MAEMO_6
            return OsType::Maemo6;
        #endif
        #ifdef Q_OS_SYMBIAN
            return OsType::Symbian;
        #endif
        #ifdef Q_OS_ANDROID
            return OsType::Android;

        #endif

        //No OS type was found
        return OsType::Unknown;
    }
signals:

public slots:

};

#endif // OSHANDLER_H
