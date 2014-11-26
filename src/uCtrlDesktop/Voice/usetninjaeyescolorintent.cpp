#include "usetninjaeyescolorintent.h"

USetNinjaEyesColorIntent::USetNinjaEyesColorIntent(UCtrlAPIFacade* uCtrlApiFacade)
{
    m_uCtrlApiFacade = uCtrlApiFacade;
}


void USetNinjaEyesColorIntent::setNinjaEyesColors(const QString& colorName)
{
    if (colorName.isEmpty())
        return;

    QColor color(colorName);
    QString colorStringValue = QString::number(color.rgb(), 16);
    colorStringValue = colorStringValue.right(6);

    QList<UDevice*> deviceList = m_uCtrlApiFacade->getPlatformsModel()->findDevicesByType(UDevice::UEType::NinjasEyes);
    foreach (UDevice* device, deviceList)
    {
        device->value(colorStringValue);
        m_uCtrlApiFacade->putDevice(device);
    }
}

