#include "udevice.h"
#include <sstream>

UDevice::UDevice(const UDevice& device)
{
    this->m_id = device.m_id;
    this->m_name = device.m_name;
}

json::Object UDevice::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDevice::FillObject(json::Object& obj)
{
    obj["m_id"] = m_id;
    obj["m_name"] = m_name;

    // WARNING : Custom code
    obj["deviceScenarios_size"] = (int) m_deviceScenarios.size();
    for (int i = 0; i < m_deviceScenarios.size(); i++)
    {
        std::ostringstream oss;
        oss << "deviceScenarios[" << i << "]";

        std::string key = oss.str();
        obj[key] = m_deviceScenarios[i].ToObject();
    }
}

std::string UDevice::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDevice::FillMembers(const json::Object& obj)
{
    m_id = obj["m_id"];
    m_name = obj["m_name"].ToString();

    // WARNING : Custom code
    int deviceScenarios_size = obj["deviceScenarios_size"];
    for (int i = 0 ; i < deviceScenarios_size; i++)
    {
        std::ostringstream oss;
        oss << "deviceScenarios[" << i << "]";

        std::string key = oss.str();
        UScenario scenario = UScenario::Deserialize(obj[key]);
        m_deviceScenarios.push_back(scenario);
    }
}

UDevice UDevice::Deserialize(const json::Object& obj)
{
	UDevice o;
	o.FillMembers(obj);
	return o;
}

