#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Serialization/JsonMacros.h"
#include "Device/udevice.h"

BEGIN_DECLARE_JSON_CLASS_ARGS4(UPlatform, int, Id, std::string, Ip, int, Port, std::vector<UDevice>, Devices)

public:
    UPlatform(const UPlatform& platform);

END_DECLARE_JSON_CLASS()

#endif // UPLATFORM_H
