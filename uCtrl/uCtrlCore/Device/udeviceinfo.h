#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include <string>

class UDeviceInfo
{
public:
    UDeviceInfo();

    float MinValue;
    float MaxValue;
    int Precision;
    std::string UnitLabel;
    int Type; // Enum?
    //UDeviceSummary
};

#endif // UDEVICEINFO_H
