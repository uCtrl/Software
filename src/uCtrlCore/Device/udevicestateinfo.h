#ifndef UDEVICESTATEINFO_H
#define UDEVICESTATEINFO_H

#include "udeviceinfo.h"
#include <map>
#include <string>

BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS0(UDeviceStateInfo, UDeviceInfo)

public:
    UDeviceStateInfo(const UDeviceStateInfo& deviceStateInfo);
    const std::map<float, std::string> getValueToNameMap() const { return m_ValueToNameMap; }
    void setValueToNameMap(const std::map<float, std::string> ValueToNameMap) { m_ValueToNameMap = ValueToNameMap; }

private:
    std::map<float, std::string> m_ValueToNameMap;
END_DECLARE_JSON_CLASS()

#endif // UDEVICESTATEINFO_H
