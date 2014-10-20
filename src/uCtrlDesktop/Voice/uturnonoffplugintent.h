#ifndef UTURNONOFFPLUGINTENT_H
#define UTURNONOFFPLUGINTENT_H

#include "uninjaapi.h"

class UTurnOnOffPlugIntent
{
    const QString SocketTypeRFCode = "11011010110110101101";
    const QString SocketOnRFCode = "1";
    const QString SocketOffRFCode = "0";
    const QString Socket1RFCode = "010";
    const QString Socket2RFCode = "100";
    const QString Socket3RFCode = "110";

    bool m_isTurnOn;
    UNinjaAPI* m_ninjaAPI;
    QString m_deviceId;
public:

    UTurnOnOffPlugIntent(UNinjaAPI* ninjaAPI, const QString& deviceId, bool turnOn);

    void turnOnOffPlugWithId(long id);
    void turnOnOffPlugInLocation(QString location);

};

#endif // UTURNONOFFPLUGINTENT_H
