#include "udevicesummary.h"

UDeviceSummary::UDeviceSummary()
{
}

UDeviceSummary::UDeviceSummary(const UDeviceSummary& deviceSummary)
{
    this->m_id = deviceSummary.m_id;
    this->m_ip = deviceSummary.m_ip;
    this->m_name = deviceSummary.m_name;
}

json::Object UDeviceSummary::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDeviceSummary::FillObject(json::Object& obj)
{
    obj["id"] = m_id;
    obj["ip"] = m_ip;
    obj["name"] = m_name;
}

std::string UDeviceSummary::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDeviceSummary::FillMembers(const json::Object& obj)
{
    m_id = obj["id"];
    m_ip = obj["ip"];
    m_name = obj["name"].ToString();
}

UDeviceSummary UDeviceSummary::Deserialize(const json::Object& obj)
{
	UDeviceSummary o;
	o.FillMembers(obj);
	return o;
}

