#ifndef UDEVICESTATEINFO_H
#define UDEVICESTATEINFO_H

#include "udeviceinfo.h"

class UDeviceStateInfo : public UDeviceInfo
{
public:
    UDeviceStateInfo();
    ~UDeviceStateInfo();

private:
    std::string Name;
    int Value;

};

#endif // UDEVICESTATEINFO_H
