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
    QString m_userAccessToken;
    QNetworkAccessManager* m_manager;
};

#endif // UNINJAAPI_H
