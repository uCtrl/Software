#ifndef UTURNONOFFPLUGINTENT_H
#define UTURNONOFFPLUGINTENT_H

#include <QObject>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include "uvoiceintent.h"

class UTurnOnOffPlugIntent : public UVoiceIntent
{
    Q_OBJECT
    bool m_isTurnOn;

    const QString SocketTypeRFCode = "11011010110110101101";
    const QString SocketOnRFCode = "1";
    const QString SocketOffRFCode = "0";
    const QString Socket1RFCode = "010";
    const QString Socket2RFCode = "100";
    const QString Socket3RFCode = "110";

QNetworkAccessManager *manager;
public:

    UTurnOnOffPlugIntent(const QString& deviceId, bool turnOn);

    void turnOnOffPlugWithId(long id);
    void turnOnOffPlugInLocation(QString location);
public slots:
    void replyFinished(QNetworkReply* reply);

};

#endif // UTURNONOFFPLUGINTENT_H
