#include "udevice.h"
#include <sstream>

UDevice::UDevice(const UDevice& device)
{
    this->m_id = device.m_id;
    this->m_name = device.m_name;
    this->m_scenarios = device.m_scenarios;
    this->m_deviceInfo = device.m_deviceInfo;
}

json::Object UDevice::ToObject() const
{
	json::Object obj;
	FillObject(obj);
	return obj;
}
json::Object UDevice::ToObjectSummary() const
{
    json::Object obj;
    FillObjectSummary(obj);
    return obj;
}

void UDevice::FillObjectSummary(json::Object& obj) const
{
    obj["id"] = m_id;
    obj["name"] = m_name;
    obj["ip"] = m_ip;
    obj["deviceInfo"] = m_deviceInfo->ToObject();
}

void UDevice::FillObject(json::Object& obj) const
{
    obj["id"] = m_id;
    obj["name"] = m_name;
    obj["ip"] = m_ip;
    obj["deviceInfo"] = m_deviceInfo->ToObject();

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
}

UDevice UDevice::Deserialize(const json::Object& obj)
{
	UDevice o;
	o.FillMembers(obj);
	return o;
}

