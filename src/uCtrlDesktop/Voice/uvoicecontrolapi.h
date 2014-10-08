#ifndef UVOICECONTROLAPI_H
#define UVOICECONTROLAPI_H

#include <QObject>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QFile>

class UVoiceControlAPI : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString voiceControlIntent READ getVoiceControlIntent WRITE setVoiceControlIntent NOTIFY onVoiceControlIntentChanged)

    QString m_voiceControlIntent;
    QNetworkAccessManager *manager;
    QFile* voiceFile;

public:
    explicit UVoiceControlAPI(QObject *parent = 0);
    Q_INVOKABLE void sendVoiceControlFile(QString voiceFilePath);
    Q_INVOKABLE void analyseIntent();

    QString getVoiceControlIntent() const
    {
        return m_voiceControlIntent;
    }

signals:

    void onVoiceControlIntentChanged(QString arg);

public slots:

    void setVoiceControlIntent(QString arg)
    {
        if (m_voiceControlIntent != arg) {
            m_voiceControlIntent = arg;
            emit onVoiceControlIntentChanged(arg);
        }
    }

    void replyFinished(QNetworkReply* reply);

private:
    void testLimitlessLED();
};


#endif // UVOICECONTROLAPI_H
