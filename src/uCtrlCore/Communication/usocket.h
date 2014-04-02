#ifndef USOCKET_H
#define USOCKET_H

#include "Serialization/jsonserializer.h"
#include <QAbstractSocket>
#include <QHostAddress>
#include <QTcpSocket>
#include <QObject>

class USocket : public QObject
{
    Q_OBJECT

public:
    USocket(const QString& ip, const int port);
    ~USocket();

    void write(JsonSerializable* requestObj);
    void write(QString requestStr);

signals:
    void hostConnected();
    void error(QAbstractSocket::SocketError error);
    void hostDisconnected();
    void received(QString message);

private slots:
    void connected();
    void displayError(QAbstractSocket::SocketError socketError);
    void disconnected();
    void bytesWritten(qint64 bytes);
    void readyRead();

private:
    QString m_ip;
    int m_port;
    QTcpSocket* m_socket;
};

#endif // USOCKET_H
