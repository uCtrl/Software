#include "uvoiceintent.h"

UVoiceIntent::UVoiceIntent(const QString& deviceId)
    : QObject(0)
{
    m_deviceId = deviceId;

    //manager = new QNetworkAccessManager(this);
    //connect(manager, SIGNAL(finished(QNetworkReply*)),
     //       this, SLOT(replyFinished(QNetworkReply*)));
}

void UVoiceIntent::sendData(const QString& data)
{
    /*
    QString url = "https://api.ninja.is/rest/v0/device/";
    url = url.append(m_deviceId);
    url = url.append("?user_access_token=");
    url = url.append(m_userAccessToken);

    QUrl urlObject(url, QUrl::ParsingMode::StrictMode);

    QNetworkRequest request;

    request.setUrl(urlObject);
    request.setRawHeader("Content-Type", "application/json");

    QString dataToSend = "{ \"DA\" : \"";
    dataToSend = dataToSend.append(data);
    dataToSend = dataToSend.append("\" }");

    QByteArray bytes = dataToSend.toUtf8();
    QNetworkReply* reply = manager->put(request, bytes);
    */
}

/*
void  UVoiceIntent::replyFinished(QNetworkReply* reply)
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
*/
