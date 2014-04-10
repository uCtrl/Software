#ifndef UCOMMUNICATIONHANDLER_H
#define UCOMMUNICATIONHANDLER_H

#include "Platform/uplatform.h"
#include "Serialization/jsonserializer.h"
#include "Communication/uemessagetype.h"
#include "Communication/Requests/getplatformrequest.h"
#include "Communication/Responses/getplatformresponse.h"

#include <QAbstractSocket>
#include <QHostAddress>
#include <QTcpSocket>
#include <QObject>

class UCommunicationHandler : public QObject
{
    Q_OBJECT

public:
    UCommunicationHandler(UPlatform* platform);
    ~UCommunicationHandler();

    void write(QString requestStr);

private slots:
    void connected();
    void displayError(QAbstractSocket::SocketError socketError);
    void disconnected();
    void readyRead();
    void destroy();

private:
    void readMessage(QString& message);

    UPlatform* m_platform;
    QTcpSocket* m_socket;
};

#endif // UCOMMUNICATIONHANDLER_H
