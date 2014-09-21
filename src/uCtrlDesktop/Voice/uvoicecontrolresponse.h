#ifndef UVOICECONTROLRESPONSE_H
#define UVOICECONTROLRESPONSE_H

#include <QJsonObject>
#include <QJsonArray>

class UVoiceControlResponse
{
public:
    UVoiceControlResponse(const QJsonObject& jsonResponse);

private:
    QString m_msgId;
    QString m_text;
    QString m_intent;
    QJsonArray m_entities;
    float m_confidence;
};

#endif // UVOICECONTROLRESPONSE_H
