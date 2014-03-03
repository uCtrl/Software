#ifndef UDEVICE_H
#define UDEVICE_H

#include <string>

class UDevice
{
public:
    UDevice();
     ~UDevice();

private:
    //Attributs
    std::string Name;
    int ID;
};

#endif // UDEVICE_H
