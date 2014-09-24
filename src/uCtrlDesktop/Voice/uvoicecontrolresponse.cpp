#include "uvoicecontrolresponse.h"

UVoiceControlResponse::UVoiceControlResponse(const QJsonObject& jsonResponse)
{
    m_msgId = jsonResponse["msg_id"].toString();

    QJsonArray outcomesArray = jsonResponse["outcomes"].toArray();
    QJsonObject firstOutcome = outcomesArray.first().toObject();
    m_text = firstOutcome["_text"].toString();
    m_intent = firstOutcome["intent"].toString();
    m_entities = firstOutcome["entities"].toObject();
    m_confidence = firstOutcome["confidence"].toDouble();
}
