#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include "Serialization/JsonMacros.h"
#include <string>

BEGIN_DECLARE_JSON_CLASS_ARGS5(UDeviceInfo, float, MinValue, float, MaxValue, int, Precision, std::string, UnitLabel, int, Type)

public:
    UDeviceInfo(const UDeviceInfo& deviceInfo);

END_DECLARE_JSON_CLASS()

#endif // UDEVICEINFO_H
