#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include <string>
#include "udevice.h"

class UDeviceInfo : public UDevice
{
public:
    UDeviceInfo();
    ~UDeviceInfo();

    //Attributs
    float MinValue;
    float MaxValue;
    int Precision;
    std::string UnitLabel;
    int Type; // Enum?
    //UDeviceSummary
};

#endif // UDEVICEINFO_H
