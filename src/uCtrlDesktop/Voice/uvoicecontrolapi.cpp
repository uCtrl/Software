#include "uvoicecontrolapi.h"
#include "uvoicecontrolresponse.h"
#include <QJsonDocument>
#include <QJsonObject>

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

UVoiceControlResponse UVoiceControlAPI::analyseIntent()
{
    QJsonDocument jsonResponse = QJsonDocument::fromJson(m_voiceControlIntent.toUtf8());
    QJsonObject jsonObj = jsonResponse.object();
    UVoiceControlResponse voiceControlResponse(jsonObj);

    if (voiceControlResponse.getIntent() == QString("turn_onoff_all_lights"))
    {
        bool onOffValue = voiceControlResponse.getOnOff("on_off");
    }
    else if (voiceControlResponse.getIntent() == QString("set_ninja_eyes_color"))
    {
        QString colorString = voiceControlResponse.getStringValue("uctrl_color");

        USetNinjaEyesColorIntent setNinjaEyesColorIntent(&m_ninjaAPI, "1014BBBK6089_0_0_1007");
        setNinjaEyesColorIntent.setNinjaEyesColors(colorString);
    }
    else if (voiceControlResponse.getIntent() == QString("turn_onoff_plugs_in_location"))
    {
        bool isOn = voiceControlResponse.getOnOff("uctrl_onoff");
        QString locationName = voiceControlResponse.getStringValue("location");

        UTurnOnOffPlugIntent intent(&m_ninjaAPI, "1014BBBK6089_0_0_11", isOn);
        intent.turnOnOffPlugInLocation(locationName);
    }
    else if (voiceControlResponse.getIntent() == QString("turn_onoff_plug_with_id"))
    {
        bool isOn = voiceControlResponse.getOnOff("uctrl_onoff");
        int plugId = voiceControlResponse.getInt("number");

        UTurnOnOffPlugIntent intent(&m_ninjaAPI, "1014BBBK6089_0_0_11", isOn);
        intent.turnOnOffPlugWithId(plugId);
    }
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

    if (voiceFile)
    {
        voiceFile->close();
        voiceFile = NULL;
    }
    delete reply;
}
