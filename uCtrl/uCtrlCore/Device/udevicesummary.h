#ifndef UDEVICESUMMARY_H
#define UDEVICESUMMARY_H

#include <string>

class UDeviceSummary
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
