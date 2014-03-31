#include "usocket.h"

USocket::USocket(const QString& ip, const int port) : m_ip(ip), m_port(port)
{
    m_socket = new QTcpSocket(this);

    connect(m_socket, SIGNAL(connected()), this, SLOT(connected()));
    connect(m_socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(displayError(QAbstractSocket::SocketError)));
    connect(m_socket, SIGNAL(disconnected()), this, SLOT(disconnected()));
    connect(m_socket, SIGNAL(bytesWritten(qint64)), this, SLOT(bytesWritten(qint64)));
    connect(m_socket, SIGNAL(readyRead()), this, SLOT(readyRead()));

    qDebug() << "connecting...";
    m_socket->connectToHost(m_ip, m_port);
}

USocket::~USocket()
{
    m_socket->disconnectFromHost();
    m_socket->close();
    delete m_socket;
}

void USocket::write(JsonSerializable* requestObj)
{
    this->write(JsonSerializer::serialize(requestObj));
}

void USocket::write(QString requestStr)
{
    qDebug() << "writting: " << requestStr;
    m_socket->write(requestStr.toUtf8().constData());
}

void USocket::connected()
{
    qDebug() << "connected...";
    emit hostConnected();
}

void USocket::disconnected()
{
    qDebug() << "disconnected...";
    emit hostDisconnected();
}

void USocket::bytesWritten(qint64 bytes)
{
    qDebug() << bytes << " bytes written...";
}

void USocket::readyRead()
{
    qDebug() << "reading...";
    QString message = m_socket->readAll();

    emit received(message);
}

void USocket::displayError(QAbstractSocket::SocketError socketError)
{
    switch (socketError) {
    case QAbstractSocket::RemoteHostClosedError:
        qDebug() << "Remote host closed the connection";
        break;
    case QAbstractSocket::HostNotFoundError:
        qDebug() << "Remote host not found";
        break;
    case QAbstractSocket::ConnectionRefusedError:
        qDebug() << "Connection refused, make sure remote host is running";
        break;
    default:
        qDebug() << "The following error occured: " << m_socket->errorString();
        break;
    }

    emit error(socketError);
}
