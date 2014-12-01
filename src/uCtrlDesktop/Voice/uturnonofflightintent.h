#ifndef UTURNONOFFLIGHTINTENT_H
#define UTURNONOFFLIGHTINTENT_H

#include <QString>
#include "Protocol/uctrlapifacade.h"
#include "Device/udevice.h"

class UTurnOnOffLightIntent
{
    bool m_isTurnOn;
    UCtrlAPIFacade* m_uCtrlApiFacade;
public:
    UTurnOnOffLightIntent(UCtrlAPIFacade* uCtrlApiFacade, bool turnOn);

    void turnOnOffAllLights();
    void turnOnOffLightsInLocation(QString locationName);
    void turnOnOffLightWithId(int id);
};

#endif // UTURNONOFFLIGHTINTENT_H
