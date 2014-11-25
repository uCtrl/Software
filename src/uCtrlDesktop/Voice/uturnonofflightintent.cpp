#include "uturnonofflightintent.h"

UTurnOnOffLightIntent::UTurnOnOffLightIntent(UCtrlAPIFacade* uCtrlApiFacade, bool turnOn)
{
    m_uCtrlApiFacade = uCtrlApiFacade;
    m_isTurnOn = turnOn;
}

void UTurnOnOffLightIntent::turnOnOffAllLights()
{
    QString data = "";

    // Ninja lights
    QList<UDevice*> deviceList = m_uCtrlApiFacade->getPlatformsModel()->findDevicesByType(UDevice::UEType::Light);
    foreach (UDevice* device, deviceList)
    {
        // TODO : Implement when we have ninja lights
        continue;
    }

    // LimitlessLED
    deviceList = m_uCtrlApiFacade->getPlatformsModel()->findDevicesByType(UDevice::UEType::LimitlessLed);
    foreach (UDevice* device, deviceList)
    {
        QJsonObject jsonLimitless = QJsonDocument::fromJson(device->value().toUtf8()).object();
        int brightness = jsonLimitless["bri"].toInt();
        if (m_isTurnOn)
            data = QString("{\\\"on\\\":true,\\\"bri\\\":%1}").arg(brightness);
        else
            data = QString("{\\\"on\\\":false,\\\"bri\\\":%1}").arg(brightness);

        device->value(data);
        m_uCtrlApiFacade->putDevice(device);
    }
}

void UTurnOnOffLightIntent::turnOnOffLightWithId(long id)
{

}

void UTurnOnOffLightIntent::turnOnOffLightsInLocation(QString locationName)
{
    QList<UDevice*> devicesInLocation = m_uCtrlApiFacade->getPlatformsModel()->findDevicesByLocation(locationName);
    foreach (UDevice* device, devicesInLocation)
    {
        QString data = "";

        // TODO : Implement when we have ninja lights
        if (device->type() == UDevice::UEType::Light)
            continue;
        else
        {
            QJsonObject jsonLimitless = QJsonDocument::fromJson(device->value().toUtf8()).object();
            int brightness = jsonLimitless["bri"].toInt();
            if (m_isTurnOn)
                data = QString("{\\\"on\\\":true,\\\"bri\\\":%1}").arg(brightness);
            else
                data = QString("{\\\"on\\\":false,\\\"bri\\\":%1}").arg(brightness);
        }
        device->value(data);
        m_uCtrlApiFacade->putDevice(device);
    }
}
