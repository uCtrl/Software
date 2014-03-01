#ifndef UDEVICESUMMARY_H
#define UDEVICESUMMARY_H

#include <string>
#include "udevice.h"

class UDeviceSummary : public UDevice
{
public:
    UDeviceSummary();
    ~UDeviceSummary();

private:
    std::string Name;
    int IP;
    int ID;

};

#endif // UDEVICESUMMARY_H
