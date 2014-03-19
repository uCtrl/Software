#ifndef UDEVICEINFO_H
#define UDEVICEINFO_H

#include "Serialization/JsonMacros.h"
#include <string>

BEGIN_DECLARE_JSON_CLASS_ARGS5(UDeviceInfo, float, m_minValue, float, m_maxValue, int, m_precision, std::string, m_unitLabel, int, m_type)

public:
    UDeviceInfo(const UDeviceInfo& deviceInfo);

END_DECLARE_JSON_CLASS()

#endif // UDEVICEINFO_H
