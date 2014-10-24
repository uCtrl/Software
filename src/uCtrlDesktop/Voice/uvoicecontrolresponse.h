#ifndef UVOICECONTROLRESPONSE_H
#define UVOICECONTROLRESPONSE_H

#include <QJsonObject>
#include <QJsonArray>
#include <QObject>

class UVoiceControlResponse : public QObject
{
    Q_OBJECT
public:
    explicit UVoiceControlResponse( QObject *parent = 0);
    explicit UVoiceControlResponse(const QJsonObject& jsonResponse, QObject *parent = 0);
    ~UVoiceControlResponse() {}

    Q_INVOKABLE QString getIntent() { return m_intent; }
    Q_INVOKABLE QString getText() { return m_text; }
    Q_INVOKABLE const QJsonObject& getEntities() { return m_entities; }
    Q_INVOKABLE float getConfidence() { return m_confidence; }
private:
    QString m_msgId;
    QString m_text;
    QString m_intent;
    QJsonObject m_entities;
    float m_confidence;
};

#endif // UVOICECONTROLRESPONSE_H
