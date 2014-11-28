#ifndef UTURNONOFFPLUGINTENT_H
#define UTURNONOFFPLUGINTENT_H

#include "uninjaapi.h"
#include "Protocol/uctrlapifacade.h"

class UTurnOnOffPlugIntent
{
    UCtrlAPIFacade* m_uCtrlApiFacade;
    bool m_isTurnOn;
public:

    UTurnOnOffPlugIntent(UCtrlAPIFacade* uCtrlApiFacade, bool turnOn);

    void turnOnOffAllPlugs();
    void turnOnOffPlugsByName(const QString& deviceName);

private:
    void turnOnOffPlugs(const QList<UDevice*>& deviceList);

};

#endif // UTURNONOFFPLUGINTENT_H
