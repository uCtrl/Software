#ifndef USETNINJAEYESCOLORINTENT_H
#define USETNINJAEYESCOLORINTENT_H

#include "uvoiceintent.h"
#include "uninjaapi.h"
#include <QColor>
#include <QRgb>

class USetNinjaEyesColorIntent
{
public:
    USetNinjaEyesColorIntent(UNinjaAPI* ninjaAPI, const QString& deviceId);

    void setNinjaEyesColors(const QString& colorName);

private:
    UNinjaAPI* m_ninjaAPI;
    QString m_deviceId;
};

#endif // USETNINJAEYESCOLORINTENT_H
