#ifndef UVOICECONTROLAPI_H
#define UVOICECONTROLAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QFile>
#include "Voice/uvoicecontrolresponse.h"
#include "Protocol/uctrlapifacade.h"

class UVoiceControlResponse;

class UVoiceControlAPI : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString voiceControlIntent READ getVoiceControlIntent WRITE setVoiceControlIntent NOTIFY onVoiceControlIntentChanged)
    Q_PROPERTY(QObject* uCtrlApiFacadeObject READ getUCtrlApiFacadeObject WRITE setUCtrlApiFacadeObject NOTIFY onUCtrlApiFacadeObjectChanged)

    QString m_voiceControlIntent;
    QNetworkAccessManager *manager;
    QFile* voiceFile;
    UNinjaAPI m_ninjaAPI;

public:
    explicit UVoiceControlAPI(QObject *parent = 0);
    Q_INVOKABLE void sendVoiceControlFile(QString voiceFilePath);
    Q_INVOKABLE void sendMessage(QString message);
    Q_INVOKABLE UVoiceControlResponse* analyseIntent();

    QString getVoiceControlIntent() const
    {
        return m_voiceControlIntent;
    }

    QObject* getUCtrlApiFacadeObject() const
    {
        return m_uCtrlApiFacadeObject;
    }

    UCtrlAPIFacade* getUCtrlApiFacade()
    {
        return (UCtrlAPIFacade*)m_uCtrlApiFacadeObject;
    }

signals:

    void onVoiceControlIntentChanged(QString arg);

    void onUCtrlApiFacadeObjectChanged(QObject* arg);

public slots:

    void setVoiceControlIntent(QString arg)
    {
        if (m_voiceControlIntent != arg) {
            m_voiceControlIntent = arg;
            emit onVoiceControlIntentChanged(arg);
        }
    }

    void replyFinished(QNetworkReply* reply);

    void setUCtrlApiFacadeObject(QObject* arg)
    {
        if (m_uCtrlApiFacadeObject == arg)
            return;

        m_uCtrlApiFacadeObject = arg;
        emit onUCtrlApiFacadeObjectChanged(arg);
    }

private:
    void testLimitlessLED();
    QObject* m_uCtrlApiFacadeObject;
};

#endif // UVOICECONTROLAPI_H
