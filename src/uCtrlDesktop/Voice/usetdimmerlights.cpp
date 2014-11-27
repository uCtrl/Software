#include "usetdimmerlights.h"

USetDimmerLights::USetDimmerLights(UCtrlAPIFacade* uCtrlApiFacade, int lightIntensityPercent)
{
    m_uCtrlApiFacade = uCtrlApiFacade;
    m_lightIntensityPercent = lightIntensityPercent;
}

void USetDimmerLights::setAllLightsIntensity()
{
    QString data = "";

    // LimitlessLED
    QList<UDevice*> deviceList = m_uCtrlApiFacade->getPlatformsModel()->findDevicesByType(UDevice::UEType::LimitlessLEDWhite);
    foreach (UDevice* device, deviceList)
    {
        QString currentValue = device->value().replace("\\", "");
        QJsonObject jsonLimitless = QJsonDocument::fromJson(currentValue.toUtf8()).object();
        bool isOn = jsonLimitless["on"].toBool();

        int rescaledLightIntensity255 = m_lightIntensityPercent * 254 / 100;

        data = QString("{\"on\":true,\"bri\":%1}").arg(QString::number(rescaledLightIntensity255));

        device->value(data);
        m_uCtrlApiFacade->putDevice(device);
    }

}
