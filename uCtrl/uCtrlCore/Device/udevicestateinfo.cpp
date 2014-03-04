#include "udevicestateinfo.h"
#include <sstream>

UDeviceStateInfo::UDeviceStateInfo(const UDeviceStateInfo& deviceStateInfo)
    : UDeviceInfo(deviceStateInfo)
{
    this->valueToNameMap = deviceStateInfo.valueToNameMap;
}

json::Object UDeviceStateInfo::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDeviceStateInfo::FillObject(json::Object& obj)
{
	UDeviceInfo::FillObject(obj);

    // WARNING : Custom code
    obj["valueToNameMap_size"] = (int)valueToNameMap.size();

    std::map<float, std::string>::iterator iter;
    int i = 0;
    for (iter = valueToNameMap.begin(); iter != valueToNameMap.end(); ++iter, ++i)
    {
        std::ostringstream oss;
        oss << "valueToNameMap_keys[" << i << "]";

        std::string key = oss.str();
        obj[key] = iter->first;

        oss.flush();
        oss << "valueToNameMap_values[" << i << "]";

        key = oss.str();
        obj[key] = iter->second;
    }
}

std::string UDeviceStateInfo::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDeviceStateInfo::FillMembers(const json::Object& obj)
{
	UDeviceInfo::FillMembers(obj);

    // WARNING : Custom code
    int valueToNameMap_size = obj["valueToNameMap_size"];
    for (int i = 0 ; i < valueToNameMap_size; i++)
    {
        std::ostringstream oss;
        oss << "valueToNameMap_keys[" << i << "]";

        std::string key = oss.str();
        float mapKey = obj[key];

        oss.flush();
        oss << "valueToNameMap_values[" << i << "]";

        key = oss.str();
        std::string mapValue = obj[key].ToString();

        valueToNameMap[mapKey] = mapValue;
    }
}

UDeviceStateInfo UDeviceStateInfo::Deserialize(const json::Object& obj)
{
	UDeviceStateInfo o;
	o.FillMembers(obj);
	return o;
}

