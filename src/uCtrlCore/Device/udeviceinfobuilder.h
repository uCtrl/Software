#ifndef UDEVICEINFOBUILDER_H
#define UDEVICEINFOBUILDER_H

#include "udeviceinfo.h"

class UDeviceInfoBuilder
{
public:
    UDeviceInfoBuilder();
    UDeviceInfoBuilder(UDeviceInfo* info);

    void setMin(float min) { m_info->m_minValue = min; }
    void setMax(float max) { m_info->m_maxValue = max; }
    void setPrecision(int precision) { m_info->m_precision = precision; }
    void setUnitLabel(const std::string& label) { m_info->m_unitLabel = label; }
    void setType(int type) { m_info->m_type = type; }
    UDeviceInfo* getDeviceInfo() { return m_info; }

private:
    UDeviceInfo* m_info;
};

#endif // UDEVICEINFOBUILDER_H
