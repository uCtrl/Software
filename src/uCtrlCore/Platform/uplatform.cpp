#include "Utility/uniqueidgenerator.h"
#include "uplatform.h"
#include "sstream"

UPlatform::UPlatform()
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UPlatform::UPlatform(const UPlatform& platform)
{
    setId(platform.getId());
    setIp(platform.getIp());
    setPort(platform.getPort());
    setDevices(platform.getDevices());
}

void UPlatform::FillObject(json::Object &obj) const
{
    obj["id"] = getId();
    obj["ip"] = getIp();
    obj["port"] = getPort();

    obj["devices_size"] = (int) getDevices().size();
    for (int i = 0; i < getDevices().size(); i++)
    {
        std::ostringstream oss;
        oss << "devices[" << i << "]";

        std::string key = oss.str();
        obj[key] = getDevices()[i].ToObject();
    }
}

void UPlatform::FillMembers(const json::Object &obj)
{
    setId(obj["id"]);
    setIp(obj["ip"].ToString());
    setPort(obj["port"]);

    int m_devices_size = obj["devices_size"];
    for (int i = 0; i < m_devices_size; i++)
    {
        std::ostringstream oss;
        oss << "devices[" << i << "]";

        std::string key = oss.str();
        UDevice device = UDevice::Deserialize(obj[key]);
        m_Devices.push_back(device);
    }
}

