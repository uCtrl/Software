#ifndef UTURNONOFFLIGHTINTENT_H
#define UTURNONOFFLIGHTINTENT_H

#include <QString>

class UTurnOnOffLightIntent
{
    bool m_isTurnOn;

public:
    UTurnOnOffLightIntent(bool turnOn)
    {
        m_isTurnOn = turnOn;
    }

    void turnOnOffAllLights();
    void turnOnOffLightWithId(long id);
    void turnOnOffLightsInLocation(QString locationName);

};

#endif // UTURNONOFFLIGHTINTENT_H
