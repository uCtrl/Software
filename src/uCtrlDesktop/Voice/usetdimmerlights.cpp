#include "usetdimmerlights.h"

USetDimmerLights::USetDimmerLights(UCtrlAPIFacade* uCtrlApiFacade, int lightIntensityPercent)
{
    m_uCtrlApiFacade = uCtrlApiFacade;
    m_lightIntensityPercent = lightIntensityPercent;
}

void USetDimmerLights::setAllLightsIntensity()
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
        bool isOn = jsonLimitless["on"].toBool();

        int rescaledLightIntensity255 = m_lightIntensityPercent * 255 / 100;

        data = QString("{\\\"on\\\":%1,\\\"bri\\\":%2}").arg(isOn, rescaledLightIntensity255);

        device->value(data);
        m_uCtrlApiFacade->putDevice(device);
    }

}
