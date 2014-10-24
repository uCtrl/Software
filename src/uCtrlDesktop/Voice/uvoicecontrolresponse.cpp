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
