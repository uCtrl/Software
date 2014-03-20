#include "udevice.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UDevice::UDevice()
{
    this->m_id = UniqueIdGenerator::GenerateUniqueId();
}

UDevice::UDevice(const UDevice& device)
{
    this->m_id = device.m_id;
    this->m_name = device.m_name;
    this->m_scenarios = device.m_scenarios;
    this->m_deviceInfo = device.m_deviceInfo;
}

void UDevice::FillObjectSummary(json::Object& obj) const
{
    obj["id"] = m_id;
    obj["name"] = m_name;
    obj["ip"] = m_ip;
    obj["deviceInfo"] = m_deviceInfo.ToObject();
}

void UDevice::FillObject(json::Object& obj) const
{
    obj["id"] = m_id;
    obj["name"] = m_name;
    obj["ip"] = m_ip;
    obj["deviceInfo"] = m_deviceInfo.ToObject();

    // WARNING : Custom code
    obj["scenarios_size"] = (int) m_scenarios.size();
    for (int i = 0; i < m_scenarios.size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarios[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_scenarios[i].ToObject();
    }
}

void UDevice::FillMembers(const json::Object& obj)
{
    m_id = obj["id"];
    m_name = obj["name"].ToString();

    // WARNING : Custom code
    int m_scenarios_size = obj["scenarios_size"];
    for (int i = 0 ; i < m_scenarios_size; i++)
    {
        std::ostringstream oss;
        oss << "scenarios[" << i << "]";

        std::string key = oss.str();
        UScenario scenario = UScenario::Deserialize(obj[key]);
        m_scenarios.push_back(scenario);
    }

    m_deviceInfo = UDeviceInfo::Deserialize(obj["deviceInfo"]);
}
