#include "udeviceinfo.h"

UDeviceInfo::UDeviceInfo()
{
}

UDeviceInfo::UDeviceInfo(const UDeviceInfo& deviceInfo)
{
    this->m_minValue = deviceInfo.m_minValue;
    this->m_maxValue = deviceInfo.m_maxValue;
    this->m_precision = deviceInfo.m_precision;
    this->m_type = deviceInfo.m_type;
    this->m_unitLabel = deviceInfo.m_unitLabel;
}

json::Object UDeviceInfo::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDeviceInfo::FillObject(json::Object& obj)
{
    obj["m_minValue"] = m_minValue;
    obj["m_maxValue"] = m_maxValue;
    obj["m_precision"] = m_precision;
    obj["m_unitLabel"] = m_unitLabel;
    obj["m_type"] = m_type;
    obj["m_deviceSummary"] = m_deviceSummary->ToObject();
}

std::string UDeviceInfo::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDeviceInfo::FillMembers(const json::Object& obj)
{
    m_minValue = obj["m_minValue"];
    m_maxValue = obj["m_maxValue"];
    m_precision = obj["m_precision"];
    m_unitLabel = obj["m_unitLabel"].ToString();
    m_type = obj["m_type"];
    UDeviceSummary summary = UDeviceSummary::Deserialize(obj["m_deviceSummary"].ToObject());
    m_deviceSummary = &summary;
}

UDeviceInfo UDeviceInfo::Deserialize(const json::Object& obj)
{
	UDeviceInfo o;
	o.FillMembers(obj);
	return o;
}

