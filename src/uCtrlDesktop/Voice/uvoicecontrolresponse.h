#ifndef UVOICECONTROLRESPONSE_H
#define UVOICECONTROLRESPONSE_H

#include <QJsonObject>
#include <QJsonArray>

class UVoiceControlResponse
{
public:
    UVoiceControlResponse(const QJsonObject& jsonResponse);

    QString getIntent() { return m_intent; }
    const QJsonObject& getEntities() { return m_entities; }
private:
    QString m_msgId;
    QString m_text;
    QString m_intent;
    QJsonObject m_entities;
    float m_confidence;
};

#endif // UVOICECONTROLRESPONSE_H
