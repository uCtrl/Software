#ifndef USETDIMMERLIGHTS_H
#define USETDIMMERLIGHTS_H

#include "Protocol/uctrlapifacade.h"

class USetDimmerLights
{
public:
    USetDimmerLights(UCtrlAPIFacade* uCtrlApiFacade, int lightIntensityPercent);

    void setAllLightsIntensity();

private:
    UCtrlAPIFacade* m_uCtrlApiFacade;
    int m_lightIntensityPercent;
};

#endif // USETDIMMERLIGHTS_H
