#include "udevice.h"
#include <sstream>

UDevice::UDevice(const UDevice& device)
{
    this->m_id = device.m_id;
    this->m_name = device.m_name;
    this->m_infos = device.m_infos;
    this->m_scenarios = device.m_scenarios;
}

void UDevice::setInformations(UDeviceInfo* infos) {
    m_infos = infos;
}

const UDeviceInfo* UDevice::getInformations() {
    return m_infos;
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
    
    // AFTER ALEXIS MERGE (verify m_scenarios)
        // WARNING : Custom code


    obj["m_scenarios_size"] = (int) m_scenarios.size();
    for (int i = 0; i < m_scenarios.size(); i++)
    {
        std::ostringstream oss;
        oss << "m_scenarios[" << i << "]";

        std::string key = oss.str();
        //obj[key] = m_scenarios[i]->ToObject();
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
        //m_scenarios.push_back(scenario);
    }
}

UDevice UDevice::Deserialize(const json::Object& obj)
{
	UDevice o;
	o.FillMembers(obj);
	return o;
}

