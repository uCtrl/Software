#ifndef USETNINJAEYESCOLORINTENT_H
#define USETNINJAEYESCOLORINTENT_H

#include "uvoiceintent.h"
#include <QColor>

class USetNinjaEyesColorIntent : UVoiceIntent
{
public:
    USetNinjaEyesColorIntent(const QString& deviceId);

    void setNinjaEyesColors(const QString& color);
};

#endif // USETNINJAEYESCOLORINTENT_H
