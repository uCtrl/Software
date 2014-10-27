#ifndef UVOICECONTROLRESPONSE_H
#define UVOICECONTROLRESPONSE_H

#include <QJsonObject>
#include <QJsonArray>
#include <QString>
#include <QColor>
#include <QObject>
#include "Voice/usetninjaeyescolorintent.h"
#include "Voice/uturnonofflightintent.h"
#include "Voice/uturnonoffplugintent.h"
#include "Voice/uninjaapi.h"

class UVoiceControlResponse : public QObject
{
    Q_OBJECT

public:
    UVoiceControlResponse(QObject* parent = 0);
    UVoiceControlResponse(const QJsonObject& jsonResponse, UNinjaAPI* ninjaAPI, QObject* parent = 0);

    Q_INVOKABLE QString getIntent() { return m_intent; }
    Q_INVOKABLE QString getText() { return m_text; }
    Q_INVOKABLE float getConfidence() { return m_confidence; }
    const QJsonObject& getEntities() { return m_entities; }

    Q_INVOKABLE bool getOnOff(const QString& onOffKey);
    Q_INVOKABLE int getInt(const QString& intKey);
    Q_INVOKABLE QString getStringValue(const QString& colorKey);

    Q_INVOKABLE QString getCommand();
    Q_INVOKABLE void sendIntent();
    bool hasValidIntent();

    Q_INVOKABLE bool isVeryConfident() { return getConfidence() >= 0.7 && hasValidIntent(); }
    Q_INVOKABLE bool isUnsure() { return getConfidence() > 0.3 && hasValidIntent(); }
private:
    QString m_msgId;
    QString m_text;
    QString m_intent;
    QJsonObject m_entities;
    float m_confidence;
    UNinjaAPI* m_ninjaAPI;

    QJsonValue getFirstJsonValue(const QString& key);
};

#endif // UVOICECONTROLRESPONSE_H
