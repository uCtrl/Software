#ifndef UDEVICESTATEINFO_H
#define UDEVICESTATEINFO_H

#include "udeviceinfo.h"
#include <map>
#include <string>

BEGIN_DECLARE_JSON_CHILD_CLASS_ARGS0(UDeviceStateInfo, UDeviceInfo)

public:
    UDeviceStateInfo(const UDeviceStateInfo& deviceStateInfo);

    std::map<float, std::string> valueToNameMap;
END_DECLARE_JSON_CLASS()

#endif // UDEVICESTATEINFO_H
