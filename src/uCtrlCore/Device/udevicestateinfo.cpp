#include "udevicestateinfo.h"
#include <sstream>

UDeviceStateInfo::UDeviceStateInfo(const UDeviceStateInfo& deviceStateInfo)
    : UDeviceInfo(deviceStateInfo)
{
    m_ValueToNameMap = deviceStateInfo.getValueToNameMap();
}

void UDeviceStateInfo::FillObject(json::Object& obj) const
{
//	UDeviceInfo::FillObject(obj);

    // WARNING : Custom code
    obj["valueToNameMap_size"] = (int)getValueToNameMap().size();

    std::map<float, std::string>::const_iterator iter;
    int i = 0;
    for (iter = getValueToNameMap().begin(); iter != getValueToNameMap().end(); ++iter, ++i)
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

void UDeviceStateInfo::FillMembers(const json::Object& obj)
{
    //	UDeviceInfo::FillMembers(obj);

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

        m_ValueToNameMap[mapKey] = mapValue;
    }
}
