#include "usetdimmerlights.h"

USetDimmerLights::USetDimmerLights(UNinjaAPI* ninjaAPI, const QString& deviceId, int lightIntensityPercent)
{
    m_ninjaAPI = ninjaAPI;
    m_deviceId = deviceId;
    m_lightIntensityPercent = lightIntensityPercent;
}

void USetDimmerLights::setAllLightsIntensity()
{
    QString data = "";

    int rescaledLightIntensity255 = m_lightIntensityPercent * 255 / 100;
    data = "{\\\"on\\\":true,\\\"bri\\\":{0}}";

    QString rescaledLightIntensity255Str = QString::number(rescaledLightIntensity255);
    data = data.replace("{0}", rescaledLightIntensity255Str);

    m_ninjaAPI->sendData(m_deviceId, data);
}
