#ifndef UDEVICE_H
#define UDEVICE_H

#include "Serialization/JsonMacros.h"
#include "Scenario/uscenario.h"
#include "Device/udeviceinfo.h"
#include <string>
#include <vector>


BEGIN_DECLARE_JSON_CLASS_ARGS4(UDevice, int, Id, std::string, Name, std::string, Ip, std::vector<UScenario>, Scenarios)

public:
    UDevice(const UDevice& device);

    void setDeviceInfo(const UDeviceInfo* deviceInfo) { m_DeviceInfo = *deviceInfo; }

    // accessors
    const UDeviceInfo* getDeviceInfo() const { return &m_DeviceInfo; }
private:
    UDeviceInfo m_DeviceInfo;

END_DECLARE_JSON_CLASS()

#endif // UDEVICE_H
