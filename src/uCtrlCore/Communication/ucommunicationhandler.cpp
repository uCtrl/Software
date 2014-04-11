#include "ucommunicationhandler.h"

UCommunicationHandler::UCommunicationHandler(UPlatform* platform)
{
    m_platform = platform;

    connect(m_platform, SIGNAL(destroyed()), this, SLOT(destroy()));

    m_socket = new QTcpSocket(this);

    connect(m_socket, SIGNAL(connected()), this, SLOT(connected()));
    connect(m_socket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(displayError(QAbstractSocket::SocketError)));
    connect(m_socket, SIGNAL(disconnected()), this, SLOT(disconnected()));
    connect(m_socket, SIGNAL(readyRead()), this, SLOT(readyRead()));

    m_socket->connectToHost(m_platform->getIp(), m_platform->getPort());
}

UCommunicationHandler::~UCommunicationHandler()
{
    m_socket->disconnectFromHost();
    m_socket->close();
    delete m_socket;
}

void UCommunicationHandler::destroy()
{
    // Careful: SUICIDE!
    delete this;
}

void UCommunicationHandler::write(QString requestStr)
{
    m_socket->write(requestStr.toUtf8().constData());
}

void UCommunicationHandler::connected()
{
    GetPlatformRequest request;
    this->write(JsonSerializer::serialize(&request));
}

void UCommunicationHandler::disconnected()
{
    qDebug() << "disconnected...";
}

void UCommunicationHandler::readyRead()
{
    QString message = m_socket->readAll();
    this->readMessage(message);
}

void UCommunicationHandler::readMessage(QString& message)
{
    QJsonObject json = QJsonDocument::fromJson(message.toUtf8()).object();

    switch (static_cast<UEMessageType>(json["messageType"].toInt())) {
    case UEMessageType::GetPlatformResponse:
    {
        qDebug() << "Get Platform response...";
        GetPlatformResponse response(m_platform);
        response.read(json);
        break;
    }
    default:
        qDebug() << "Unknown message type...";
        break;
    }
}

void UCommunicationHandler::displayError(QAbstractSocket::SocketError socketError)
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
}
