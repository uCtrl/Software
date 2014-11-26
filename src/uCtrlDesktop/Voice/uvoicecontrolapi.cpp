#include "uvoicecontrolapi.h"
#include "uvoicecontrolresponse.h"
#include <QJsonDocument>
#include <QJsonObject>

UVoiceControlAPI::UVoiceControlAPI(QObject *parent) :
    QObject(parent)
{
    voiceFile = NULL;
    manager = new QNetworkAccessManager(this);
    connect(manager, SIGNAL(finished(QNetworkReply*)),
            this, SLOT(replyFinished(QNetworkReply*)));
}

void UVoiceControlAPI::sendVoiceControlFile(QString voiceFilePath)
{
    QNetworkRequest request;
    request.setUrl(QUrl("https://api.wit.ai/speech"));
    request.setRawHeader("Authorization", "Bearer AJKFKPXCCXDD6CPEXASZMJSLCOZSUQ3Z");
    request.setRawHeader("Content-Type", "audio/wav");

    voiceFile = new QFile(voiceFilePath);
    if (!voiceFile->open(QIODevice::ReadOnly))
        return;

    QNetworkReply* reply = manager->post(request, voiceFile);

    voiceFile->setParent(reply);
}

void UVoiceControlAPI::sendMessage(QString message)
{
    QString url = QString("https://api.wit.ai/message?v=20141125&q=%1").arg(message).replace(" ", "%20");
    QNetworkRequest request;
    request.setUrl(QUrl(url));
    request.setRawHeader("Authorization", "Bearer AJKFKPXCCXDD6CPEXASZMJSLCOZSUQ3Z");

    QNetworkReply* reply = manager->get(request);
}

UVoiceControlResponse* UVoiceControlAPI::analyseIntent()
{
    QJsonDocument jsonResponse = QJsonDocument::fromJson(m_voiceControlIntent.toUtf8());
    QJsonObject jsonObj = jsonResponse.object();
    UVoiceControlResponse* voiceControlResponse = new UVoiceControlResponse(jsonObj, &m_ninjaAPI, this);

    return voiceControlResponse;
}

void  UVoiceControlAPI::replyFinished(QNetworkReply* reply)
{
    // Reading attributes of the reply
    QVariant statusCodeV =
    reply->attribute(QNetworkRequest::HttpStatusCodeAttribute);

    if (statusCodeV.toInt() == 200)
    {
        setVoiceControlIntent(QString(reply->readAll()));
    }
    // Some http error or redirect
    else
    {
        QString error = reply->errorString();
    }

    if (voiceFile != NULL)
    {
        voiceFile->close();
        delete voiceFile;
        voiceFile = NULL;
    }
    delete reply;
}
