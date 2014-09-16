#ifndef UNINJABLOCKSAPI_H
#define UNINJABLOCKSAPI_H

#include <QObject>
#include <QtNetwork>

const QString NinjaBaseUrl = "https://api.ninja.is/rest/v0/";
const QString UserAccessToken = "107f6f460bed2dbb10f0a93b994deea7fe07dad5";

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
    void networkError(QNetworkReply::NetworkError err);

public slots:

private slots:
    void parseResponse(QNetworkReply* reply);

private:
    void sendRequest(const QString &url);

    QNetworkAccessManager* m_networkAccessManager;
};

#endif // UNINJABLOCKSAPI_H
