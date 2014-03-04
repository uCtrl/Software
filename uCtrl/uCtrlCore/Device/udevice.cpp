#include "udevice.h"
#include <sstream>

UDevice::UDevice(const UDevice& device)
{
    this->id = device.id;
    this->name = device.name;
}

json::Object UDevice::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDevice::FillObject(json::Object& obj)
{
	obj["id"] = id;
	obj["name"] = name;

    // WARNING : Custom code
    obj["deviceScenarios_size"] = (int) deviceScenarios.size();
    for (int i = 0; i < deviceScenarios.size(); i++)
    {
        std::ostringstream oss;
        oss << "deviceScenarios[" << i << "]";

        std::string key = oss.str();
        obj[key] = deviceScenarios[i].ToObject();
    }
}

std::string UDevice::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDevice::FillMembers(const json::Object& obj)
{
	id = obj["id"];
	name = obj["name"].ToString();

    // WARNING : Custom code
    int deviceScenarios_size = obj["deviceScenarios_size"];
    for (int i = 0 ; i < deviceScenarios_size; i++)
    {
        std::ostringstream oss;
        oss << "deviceScenarios[" << i << "]";

        std::string key = oss.str();
        UScenario scenario = UScenario::Deserialize(obj[key]);
        deviceScenarios.push_back(scenario);
    }
}

UDevice UDevice::Deserialize(const json::Object& obj)
{
	UDevice o;
	o.FillMembers(obj);
	return o;
}

