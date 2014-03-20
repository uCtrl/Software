#ifndef UPLATFORMBUILDER_H
#define UPLATFORMBUILDER_H

#include "Platform/uplatform.h"
#include "Device/udevice.h"
#include "Device/udevicebuilder.h"

class UPlatformBuilder
{
public:
    UPlatformBuilder();
    UPlatformBuilder(const UPlatform& platform);
    void loadFromJsonString( std::string data );

    void setId(int id) { m_platform.m_id = id;}
    void setIp(const std::string& ip) { m_platform.m_ip = ip; }
    void setPort(int port) { m_platform.m_port = port; }

    UDeviceBuilder* createDevice();
    UDeviceBuilder* editDevice(int deviceId);
    void deleteDevice(int deviceId);

    const UPlatform* getPlatform() const { return &m_platform; }

private:
    UPlatform m_platform;
};


#endif // UPLATFORMBUILDER_H
