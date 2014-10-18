#include "uturnonoffplugintent.h"

UTurnOnOffPlugIntent::UTurnOnOffPlugIntent(const QString& deviceId, bool turnOn)
    : UVoiceIntent(deviceId)
{
    m_isTurnOn = turnOn;


    manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));
}

void UTurnOnOffPlugIntent::turnOnOffPlugWithId(long id)
{
    QString data(SocketTypeRFCode);

    if (m_isTurnOn)
        data = data.append(SocketOnRFCode);
    else
        data = data.append(SocketOffRFCode);

    if (id == 1)
        data = data.append(Socket1RFCode);
    else if (id == 2)
        data = data.append(Socket2RFCode);
    else if (id == 3)
        data = data.append(Socket3RFCode);
    else
        return;

    //for (int i = 0; i < 10; i++) {
    QString url = "https://api.ninja.is/rest/v0/device/";
    url = url.append(m_deviceId);
    url = url.append("?user_access_token=");
    url = url.append(m_userAccessToken);

    //QUrl urlObject(url, QUrl::ParsingMode::StrictMode);
/*
    QNetworkRequest request;

    request.setUrl(QUrl("https://api.ninja.is/rest/v0/device/1014BBBK6089_0_0_11?user_access_token=107f6f460bed2dbb10f0a93b994deea7fe07dad5"));
    request.setRawHeader("Content-Type", "application/json");

    QString dataToSend = "{ \"DA\" : \"";
    dataToSend = dataToSend.append(data);
    dataToSend = dataToSend.append("\" }");

    QByteArray bytes = dataToSend.toUtf8();
    QNetworkReply* reply = manager->put(request, bytes);
*/


        QNetworkRequest request;

        request.setUrl(QUrl("https://api.ninja.is/rest/v0/device/1014BBBK6089_0_0_11?user_access_token=107f6f460bed2dbb10f0a93b994deea7fe07dad5"));
        request.setRawHeader("Content-Type", "application/json");

        QString dataToSend = "";

        if (m_isTurnOn)
            dataToSend = "{ \"DA\" : \"110110101101101011011100\" }";
        else
            dataToSend = "{ \"DA\" : \"110110101101101011010100\" }";

        QByteArray bytes = dataToSend.toUtf8();
        QNetworkReply* reply = manager->put(request, bytes);

    //}
    //sendData(data);
}



void UTurnOnOffPlugIntent::turnOnOffPlugInLocation(QString location)
{
    if (location == QString("living room"))
    {
        turnOnOffPlugWithId(1);
    }
    else if (location == QString("kitchen"))
    {
        turnOnOffPlugWithId(2);
        turnOnOffPlugWithId(3);
    }
}

void  UTurnOnOffPlugIntent::replyFinished(QNetworkReply* reply)
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
