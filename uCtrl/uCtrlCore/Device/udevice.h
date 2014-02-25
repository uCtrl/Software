#ifndef UDEVICE_H
#define UDEVICE_H

#include <string>

class UDevice
{
public:
    UDevice();
     ~UDevice();

    virtual void UDeviceCreate() = 0;
    virtual void UDeviceEdit() = 0;
    virtual void UDeviceDelete() = 0;
    virtual void SensorRead() = 0;

private:
    std::string Name;
    int ID;
};

#endif // UDEVICE_H
