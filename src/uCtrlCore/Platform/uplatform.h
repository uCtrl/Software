#ifndef UPLATFORM_H
#define UPLATFORM_H

#include "Serialization/JsonMacros.h"
#include "Device/udevice.h"

BEGIN_DECLARE_JSON_CLASS_ARGS4(UPlatform, int, m_id, std::string, m_ip, int, m_port, std::vector<UDevice>, m_devices)

public:
    UPlatform(const UPlatform& platform);

    int getId() const { return m_id; }
    const std::string& getIp() const { return m_ip; }
    int getPort() const { return m_port; }
    const std::vector<UDevice>& getAllDevices() const { return m_devices; }

END_DECLARE_JSON_CLASS()

#endif // UPLATFORM_H
