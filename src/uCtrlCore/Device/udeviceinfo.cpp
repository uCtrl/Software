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

void UDeviceInfo::FillObject(json::Object& obj) const
{
    obj["minValue"] = m_minValue;
    obj["maxValue"] = m_maxValue;
    obj["precision"] = m_precision;
    obj["unitLabel"] = m_unitLabel;
    obj["type"] = m_type;
}

void UDeviceInfo::FillMembers(const json::Object& obj)
{
    m_minValue = obj["minValue"];
    m_maxValue = obj["maxValue"];
    m_precision = obj["precision"];
    m_unitLabel = obj["unitLabel"].ToString();
    m_type = obj["type"];
}
