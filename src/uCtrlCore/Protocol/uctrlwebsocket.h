#ifndef UCTRLWEBSOCKET_H
#define UCTRLWEBSOCKET_H

#include <QtWebSockets/QWebSocket>
#include <QObject>
#include "Platform/uplatformsmodel.h"

class UCtrlWebSocket : public QObject
{
    Q_OBJECT

public:
    UCtrlWebSocket(UPlatformsModel* platforms, const QString& userToken, QObject *parent = 0);
    ~UCtrlWebSocket();

    void open(QUrl url);

signals:
    void websocketError(const QString& error);

private slots:
    void onConnected();
    void onError(QAbstractSocket::SocketError error);
    void onMessageReceived(const QString& message);
    void onClosed();

private:
    enum class UETarget: int {
        Platform = 1,
        Device = 2,
        Scenario = 3,
        Task = 4,
        Condition = 5
    };

    enum class UEAction: int {
        Create = 1,
        Update = 2,
        Delete = 3,
    };

    void treatPlatform(const QJsonObject& message);
    void treatDevice(const QJsonObject& message);
    void treatScenario(const QJsonObject& message);
    void treatTask(const QJsonObject& message);
    void treatCondition(const QJsonObject& message);

    QWebSocket m_webSocket;
    UPlatformsModel* m_platforms;
    QString m_userToken;
};

#endif // UCTRLWEBSOCKET_H
