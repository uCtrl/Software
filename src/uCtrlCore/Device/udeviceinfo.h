#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include "Serialization/JsonMacros.h"
#include "udevicesummary.h"
#include <string>

BEGIN_DECLARE_JSON_CLASS_ARGS6(UDeviceInfo, float, minValue, float, maxValue, int, precision, std::string, unitLabel, int, type, UDeviceSummary*, m_summary)

public:
    UDeviceInfo(const UDeviceInfo& deviceInfo);

END_DECLARE_JSON_CLASS()

#endif // UDEVICEINFO_H
