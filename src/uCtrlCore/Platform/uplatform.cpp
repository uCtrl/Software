#include "Utility/uniqueidgenerator.h"
#include "uplatform.h"
#include "sstream"

UPlatform::UPlatform()
{
    this->m_id = UniqueIdGenerator::GenerateUniqueId();
}

UPlatform::UPlatform(const UPlatform& platform)
{
    this->m_id = platform.m_id;
    this->m_ip = platform.m_ip;
    this->m_port = platform.m_port;
    this->m_devices = platform.m_devices;
}

void UPlatform::FillObject(json::Object &obj) const
{
    obj["id"] = m_id;
    obj["ip"] = m_ip;
    obj["port"] = m_port;

    obj["devices_size"] = (int) m_devices.size();
    for (int i = 0; i < m_devices.size(); i++)
    {
        std::ostringstream oss;
        oss << "devices[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_devices[i].ToObject();
    }
}

void UPlatform::FillMembers(const json::Object &obj)
{
    m_id = obj["id"];
    m_ip = obj["ip"].ToString();
    m_port = obj["port"];

    int m_devices_size = obj["devices_size"];
    for (int i = 0; i < m_devices_size; i++)
    {
        std::ostringstream oss;
        oss << "devices[" << i << "]";

        std::string key = oss.str();
        UDevice device = UDevice::Deserialize(obj[key]);
        m_devices.push_back(device);
    }
}

