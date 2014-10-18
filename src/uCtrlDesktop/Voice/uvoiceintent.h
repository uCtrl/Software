#ifndef UVOICEINTENT_H
#define UVOICEINTENT_H

#include <QObject>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>

namespace EUVoiceIntentType
{
    enum Name
    {
        SetDimmerLightsInLocation,
        SetNinjaEyesColor,
        TurnOnOffAllLights,
        TurnOnOffLightWithId,
        TurnOnOffLightsInLocation,
        TurnOnOffPlugWithId,
        TurnOnOffPlugInLocation
    };
}

class UVoiceIntent : public QObject
{
    Q_OBJECT
public:
    // Hardcoded user access token
    const QString m_userAccessToken = "107f6f460bed2dbb10f0a93b994deea7fe07dad5";

    QString m_deviceId;

    //QNetworkAccessManager *manager;
public:
    explicit UVoiceIntent(QObject* parent = 0) : QObject(parent) {}
    UVoiceIntent(const QString& deviceId);

protected:
    void sendData(const QString& data);

//private slots:
//    void replyFinished(QNetworkReply* reply);
};

#endif // UVOICEINTENT_H
