#ifndef USETNINJAEYESCOLORINTENT_H
#define USETNINJAEYESCOLORINTENT_H

#include "uvoiceintent.h"
#include "Protocol/uctrlapifacade.h"
#include "Device/udevice.h"
#include <QColor>
#include <QRgb>

class USetNinjaEyesColorIntent
{
public:
    USetNinjaEyesColorIntent(UCtrlAPIFacade* uCtrlApiFacade);

    void setNinjaEyesColors(const QString& colorName);

private:
    UCtrlAPIFacade* m_uCtrlApiFacade;
};

#endif // USETNINJAEYESCOLORINTENT_H
