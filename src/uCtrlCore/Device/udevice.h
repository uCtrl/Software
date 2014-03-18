#ifndef UDEVICE_H
#define UDEVICE_H

#include "Serialization/JsonMacros.h"
#include "Scenario/uscenario.h"
#include "Device/udeviceinfo.h"
#include <string>
#include <vector>


BEGIN_DECLARE_JSON_CLASS_ARGS4(UDevice, int, m_id, std::string, m_name, std::string, m_ip, std::vector<UScenario>, m_scenarios)

public:
    UDevice(const UDevice& device);

    void setDeviceInfo(UDeviceInfo* deviceInfo);

    // accessors
    int id() const { return m_id; }
    std::string ip() const { return m_ip; }
    const std::string& name() const { return m_name; }
    const std::vector<UScenario>& scenarios() const { return m_scenarios; }
    const UDeviceInfo* getDeviceInfo() const { return &m_deviceInfo; }

    UDeviceInfo m_deviceInfo;

END_DECLARE_JSON_CLASS()

#endif // UDEVICE_H
