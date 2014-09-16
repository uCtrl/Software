#ifndef UNINJABLOCKSAPI_H
#define UNINJABLOCKSAPI_H

#include <QObject>
#include <QtNetwork>

const QString NinjaBaseUrl = "https://api.ninja.is/rest/v0/";

class UNinjaBlocksAPI : public QObject
{
    Q_OBJECT

public:
    explicit UNinjaBlocksAPI(QNetworkAccessManager* nam, QObject *parent = 0);
    Q_INVOKABLE void getBlocks();
    Q_INVOKABLE void getBlock(const QString& blockId);
    Q_INVOKABLE void getDevices();
    Q_INVOKABLE void getDevice(const QString& deviceId);
    Q_INVOKABLE void getRules();

signals:

public slots:

private slots:
    void parseResponse(QNetworkReply* reply);

private:
    void sendRequest(const QString &url);

    QNetworkAccessManager* m_networkAccessManager;
};

#endif // UNINJABLOCKSAPI_H
