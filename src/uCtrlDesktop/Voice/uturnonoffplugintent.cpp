#include "uturnonoffplugintent.h"

UTurnOnOffPlugIntent::UTurnOnOffPlugIntent(UCtrlAPIFacade* uCtrlApiFacade, bool turnOn)
{
    m_uCtrlApiFacade = uCtrlApiFacade;
    m_isTurnOn = turnOn;
}

void UTurnOnOffPlugIntent::turnOnOffAllPlugs()
{
    UPlatformsModel* platforms = m_uCtrlApiFacade->getPlatformsModel();
    QList<UDevice*> deviceList = platforms->findDevicesByType(UDevice::UEType::PowerSocketSwitch);

    turnOnOffPlugs(deviceList);
}

void UTurnOnOffPlugIntent::turnOnOffPlugsByName(const QString& deviceName)
{
    UPlatformsModel* platforms = m_uCtrlApiFacade->getPlatformsModel();
    QList<UDevice*> deviceList = platforms->findDevicesByTypeAndName(UDevice::UEType::PowerSocketSwitch, deviceName);

    turnOnOffPlugs(deviceList);
}

void UTurnOnOffPlugIntent::turnOnOffPlugs(const QList<UDevice*>& deviceList)
{
    QString nextDeviceValue = m_isTurnOn ? "1" : "0";
    foreach (UDevice* device, deviceList)
    {
        device->value(nextDeviceValue);
        m_uCtrlApiFacade->putDevice(device);
    }
}
