#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include "Serialization/JsonMacros.h"
#include "udevicesummary.h"
#include "../Device/udevice.h"
#include <string>

BEGIN_DECLARE_JSON_CLASS_ARGS6(UDeviceInfo, float, minValue, float, maxValue, int, precision, std::string, unitLabel, int, type, UDeviceSummary, deviceSummary)

public:
    UDeviceInfo(const UDeviceInfo& deviceInfo);

private:
    UDevice m_device;

END_DECLARE_JSON_CLASS()

#endif // UDEVICEINFO_H
