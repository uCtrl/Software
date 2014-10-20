#ifndef UNINJAAPI_H
#define UNINJAAPI_H

#include <QObject>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

class UNinjaAPI : public QObject
{
    Q_OBJECT
public:
    explicit UNinjaAPI(QObject *parent = 0);

    void sendData(const QString& deviceId, const QString& data);

private slots:
    void replyFinished(QNetworkReply* reply);
private:
    // Hardcoded user access token
    const QString m_userAccessToken = "107f6f460bed2dbb10f0a93b994deea7fe07dad5";
    QNetworkAccessManager* m_manager;
};

#endif // UNINJAAPI_H
