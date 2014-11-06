#ifndef USETDIMMERLIGHTS_H
#define USETDIMMERLIGHTS_H

#include "uninjaapi.h"

class USetDimmerLights
{

public:
    USetDimmerLights(UNinjaAPI* ninjaAPI, const QString& deviceId, int lightIntensityPercent);

    void setAllLightsIntensity();

private:
    UNinjaAPI* m_ninjaAPI;
    QString m_deviceId;
    int m_lightIntensityPercent;
};

#endif // USETDIMMERLIGHTS_H
