#include "uvoicecontrolresponse.h"

UVoiceControlResponse::UVoiceControlResponse(QObject *parent)
    : QObject(parent)
{
}

UVoiceControlResponse::UVoiceControlResponse(const QJsonObject& jsonResponse, QObject *parent)
    : QObject(parent)
{
    m_msgId = jsonResponse["msg_id"].toString();
    m_text = jsonResponse["_text"].toString();

    QJsonArray outcomesArray = jsonResponse["outcomes"].toArray();
    QJsonObject firstOutcome = outcomesArray.first().toObject();

    m_intent = firstOutcome["intent"].toString();
    m_entities = firstOutcome["entities"].toObject();
    m_confidence = firstOutcome["confidence"].toDouble();
}

bool UVoiceControlResponse::getOnOff(const QString& onOffKey)
{
    QString valueString = getFirstJsonValue(onOffKey).toString();

    bool isOn = false;
    if (valueString == QString("on"))
        isOn = true;
    else if (valueString == QString("off"))
        isOn = false;

    return isOn;
}

int UVoiceControlResponse::getInt(const QString& intKey)
{
    int intValue = getFirstJsonValue(intKey).toInt();
    return intValue;
}

QString UVoiceControlResponse::getStringValue(const QString& stringKey)
{
    QString stringValue = getFirstJsonValue(stringKey).toString();
    return stringValue;
}

QJsonValue UVoiceControlResponse::getFirstJsonValue(const QString& key)
{
    QJsonObject entities = getEntities();
    QJsonValue jsonValue = entities[key];
    QJsonArray jsonArray = jsonValue.toArray();
    QJsonObject firstObject = jsonArray.first().toObject();
    QJsonValue firstJsonValue = firstObject["value"];
    return firstJsonValue;
}
