#include "uvoicecontrolapi.h"

UVoiceControlAPI::UVoiceControlAPI(QObject *parent) :
    QObject(parent)
{
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

    //voiceFilePath = "C:/Users/Frank/Desktop/c29decaada78f883c58fec7d46bb04a7.wav";
    voiceFile = new QFile(voiceFilePath);
    if (!voiceFile->open(QIODevice::ReadOnly))
        return;

    QNetworkReply* reply = manager->post(request, voiceFile);

    voiceFile->setParent(reply);
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

    if (voiceFile)
    {
        voiceFile->close();
        voiceFile = NULL;
    }
    delete reply;
}
