#include "uturnonofflightintent.h"

UTurnOnOffLightIntent::UTurnOnOffLightIntent(UCtrlAPIFacade* uCtrlApiFacade, bool turnOn)
{
    m_uCtrlApiFacade = uCtrlApiFacade;
    m_isTurnOn = turnOn;
}

void UTurnOnOffLightIntent::turnOnOffAllLights()
{
    QString data = "";

    // LimitlessLED
    QList<UDevice*> deviceList = m_uCtrlApiFacade->getPlatformsModel()->findDevicesByType(UDevice::UEType::LimitlessLEDWhite);
    foreach (UDevice* device, deviceList)
    {
        QString currentValue = device->value().replace("\\", "");
        QJsonObject jsonLimitless = QJsonDocument::fromJson(currentValue.toUtf8()).object();
        int brightness = jsonLimitless["bri"].toDouble();
        if (m_isTurnOn)
            data = QString("{\"on\":true,\"bri\":%1}").arg(brightness);
        else
            data = QString("{\"on\":false,\"bri\":%1}").arg(brightness);

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
        if (device->type() != UDevice::UEType::LimitlessLEDWhite)
            continue;

        QString data = "";

        QString currentValue = device->value().replace("\\", "");
        QJsonObject jsonLimitless = QJsonDocument::fromJson(currentValue.toUtf8()).object();
        int brightness = jsonLimitless["bri"].toDouble();
        if (m_isTurnOn)
            data = QString("{\"on\":true,\"bri\":%1}").arg(brightness);
        else
            data = QString("{\"on\":false,\"bri\":%1}").arg(brightness);

        device->value(data);
        m_uCtrlApiFacade->putDevice(device);
    }
}
