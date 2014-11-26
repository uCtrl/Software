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
        if (device->type() != UDevice::UEType::LimitlessLEDWhite)
            continue;

        QString data = "";

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
