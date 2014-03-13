#ifndef UDEVICEINFOBUILDER_H
#define UDEVICEINFOBUILDER_H

#include "udeviceinfo.h"
#include "udevicesummary.h"
#include "udevicesummarybuilder.h"

class UDeviceInfoBuilder
{
public:
    UDeviceInfoBuilder();
    UDeviceInfoBuilder(UDeviceInfo* info);

    void setMin(float min) { m_info->minValue = min; }
    void setMax(float max) { m_info->maxValue = max; }
    void setPrecision(int precision) { m_info->precision = precision; }
    void setUnitLabel(std::string label) { m_info->unitLabel = label; }
    void setType(int type) { m_info->type = type; }

    UDeviceSummaryBuilder* createDeviceSummary();
    void setDeviceSummary(UDeviceSummary* summary) { m_info->m_summary = summary; }

    UDeviceInfo* getDeviceInfo() { return m_info; }

private:
    UDeviceInfo* m_info;
};

#endif // UDEVICEINFOBUILDER_H
