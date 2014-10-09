#ifndef UTURNONFFPLUGINTENT_H
#define UTURNONFFPLUGINTENT_H

#include <QString>

class UTurnOnffPlugIntent
{
    bool m_isTurnOn;

public:
    UTurnOnffPlugIntent(bool turnOn)
    {
        m_isTurnOn = turnOn;
    }

    void turnOnOffPlugWithId(long id);
    void turnOnOffPlugInLocation(QString location);
};

#endif // UTURNONFFPLUGINTENT_H
