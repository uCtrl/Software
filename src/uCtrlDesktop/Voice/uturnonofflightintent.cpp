#include "uturnonofflightintent.h"

UTurnOnOffLightIntent::UTurnOnOffLightIntent(UNinjaAPI *ninjaAPI, const QString &deviceId, bool turnOn)
{
    m_ninjaAPI = ninjaAPI;
    m_deviceId = deviceId;
    m_isTurnOn = turnOn;
}

void UTurnOnOffLightIntent::turnOnOffAllLights()
{
    QString data = "";

    if (m_isTurnOn)
        data = "{\\\"on\\\":true,\\\"bri\\\":50}";
    else
        data = "{\\\"on\\\":false,\\\"bri\\\":50}";

    m_ninjaAPI->sendData(m_deviceId, data);
}

void UTurnOnOffLightIntent::turnOnOffLightWithId(long id)
{

}

void UTurnOnOffLightIntent::turnOnOffLightsInLocation(QString locationName)
{

}
