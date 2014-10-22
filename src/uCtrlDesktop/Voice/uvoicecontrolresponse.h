#ifndef UVOICECONTROLRESPONSE_H
#define UVOICECONTROLRESPONSE_H

#include <QJsonObject>
#include <QJsonArray>
#include <QString>
#include <QColor>

class UVoiceControlResponse
{
public:
    UVoiceControlResponse(const QJsonObject& jsonResponse);

    QString getIntent() { return m_intent; }
    const QJsonObject& getEntities() { return m_entities; }

    bool getOnOff(const QString& onOffKey);
    int getInt(const QString& intKey);
    QString getStringValue(const QString& colorKey);
private:
    QString m_msgId;
    QString m_text;
    QString m_intent;
    QJsonObject m_entities;
    float m_confidence;

    QJsonValue getFirstJsonValue(const QString& key);
};

#endif // UVOICECONTROLRESPONSE_H
