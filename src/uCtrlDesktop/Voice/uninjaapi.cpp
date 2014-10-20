#include "uninjaapi.h"

UNinjaAPI::UNinjaAPI(QObject *parent) :
    QObject(parent)
{
    m_manager = new QNetworkAccessManager(this);
    connect(m_manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));
}

void UNinjaAPI::sendData(const QString& deviceId, const QString& data)
{
    QString url = "https://api.ninja.is/rest/v0/device/";
    url = url.append(deviceId);
    url = url.append("?user_access_token=");
    url = url.append(m_userAccessToken);

    QUrl urlObject(url);

    QNetworkRequest request;

    request.setUrl(urlObject);
    request.setRawHeader("Content-Type", "application/json");

    QString dataToSend = "{ \"DA\" : \"";
    dataToSend = dataToSend.append(data);
    dataToSend = dataToSend.append("\" }");

    QByteArray bytes = dataToSend.toUtf8();
    QNetworkReply* reply = m_manager->put(request, bytes);
}

void  UNinjaAPI::replyFinished(QNetworkReply* reply)
{
    // Reading attributes of the reply
    QVariant statusCodeV =
    reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);

    if (statusCodeV.toInt() == 200)
    {
    }
    // Some http error or redirect
    else
    {
        QString error = reply->errorString();
    }

    delete reply;
}
