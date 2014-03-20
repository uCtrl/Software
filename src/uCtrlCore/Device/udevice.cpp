#include "udevice.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UDevice::UDevice()
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UDevice::UDevice(const UDevice& device)
{
    setId(device.getId());
    setName(device.getName());
    setScenarios(device.getScenarios());
    setDeviceInfo(device.getDeviceInfo());
}

void UDevice::FillObjectSummary(json::Object& obj) const
{
    obj["id"] = getId();
    obj["name"] = getName();
    obj["ip"] = getIp();
    obj["deviceInfo"] = getDeviceInfo()->ToObject();
}

void UDevice::FillObject(json::Object& obj) const
{
    obj["id"] = getId();
    obj["name"] = getName();
    obj["ip"] = getIp();
    obj["deviceInfo"] = getDeviceInfo()->ToObject();

    // WARNING : Custom code
    obj["scenarios_size"] = (int) getScenarios().size();
    for (int i = 0; i < getScenarios().size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarios[" << i << "]";

        std::string key = oss.str();
        obj[key] = getScenarios()[i].ToObject();
    }
}

void UDevice::FillMembers(const json::Object& obj)
{
    setId(obj["id"]);
    setName(obj["name"].ToString());

    // WARNING : Custom code
    int m_scenarios_size = obj["scenarios_size"];
    for (int i = 0 ; i < m_scenarios_size; i++)
    {
        std::ostringstream oss;
        oss << "scenarios[" << i << "]";

        std::string key = oss.str();
        UScenario scenario = UScenario::Deserialize(obj[key]);
        m_Scenarios.push_back(scenario);
    }
    m_DeviceInfo = UDeviceInfo::Deserialize(obj["deviceInfo"]);
}
