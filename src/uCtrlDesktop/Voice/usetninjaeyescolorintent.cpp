#include "usetninjaeyescolorintent.h"

USetNinjaEyesColorIntent::USetNinjaEyesColorIntent(UNinjaAPI* ninjaAPI, const QString& deviceId)
{
    m_ninjaAPI = ninjaAPI;
    m_deviceId = deviceId;
}


void USetNinjaEyesColorIntent::setNinjaEyesColors(const QString& colorName)
{
    if (colorName.isEmpty())
        return;

    QColor color(colorName);

    QString colorStringValue = QString::number(color.rgb(), 16);
    colorStringValue = colorStringValue.right(6);
    m_ninjaAPI->sendData(m_deviceId, colorStringValue);
}

