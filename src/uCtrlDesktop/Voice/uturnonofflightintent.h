#ifndef UTURNONOFFLIGHTINTENT_H
#define UTURNONOFFLIGHTINTENT_H

#include "uninjaapi.h"
#include <QString>

class UTurnOnOffLightIntent
{
    bool m_isTurnOn;
    UNinjaAPI* m_ninjaAPI;
    QString m_deviceId;
public:
    UTurnOnOffLightIntent(UNinjaAPI* ninjaAPI, const QString& deviceId, bool turnOn);

    void turnOnOffAllLights();
    void turnOnOffLightWithId(long id);
    void turnOnOffLightsInLocation(QString locationName);
};

#endif // UTURNONOFFLIGHTINTENT_H
