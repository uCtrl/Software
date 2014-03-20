#include "uplatformbuilder.h"
#include "Utility/uniqueidgenerator.h"

UPlatformBuilder::UPlatformBuilder()
{
    m_platform.m_id = UniqueIdGenerator::GenerateUniqueId();
}

UPlatformBuilder::UPlatformBuilder(const UPlatform &platform)
{
    m_platform = platform;
}

void UPlatformBuilder::loadFromJsonString(std::string data)
{
    this->m_platform = UPlatform::Deserialize(json::Deserialize(data));
}

UDeviceBuilder* UPlatformBuilder::createDevice()
{
    return new UDeviceBuilder();
}

UDeviceBuilder* UPlatformBuilder::editDevice(int deviceId)
{
    for (int i = 0; i < m_platform.m_devices.size(); i++)
    {
        if (m_platform.m_devices[i].m_id == deviceId)
        {
            UDeviceBuilder* deviceBuilder = new UDeviceBuilder(m_platform.m_devices[i]);
            return deviceBuilder;
        }
    }
}

void UPlatformBuilder::deleteDevice(int deviceId)
{
    for (int i = 0; i < m_platform.m_devices.size(); i++)
    {
        if (m_platform.m_devices[i].m_id == deviceId)
        {
            std::vector<UDevice>::iterator iter = m_platform.m_devices.begin() + i;
            m_platform.m_devices.erase(iter);
            return;
        }
    }
}


