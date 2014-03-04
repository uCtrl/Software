#include "udevicesummary.h"

UDeviceSummary::UDeviceSummary(const UDeviceSummary& deviceSummary)
{
    this->id = deviceSummary.id;
    this->ip = deviceSummary.ip;
    this->name = deviceSummary.name;
}

json::Object UDeviceSummary::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDeviceSummary::FillObject(json::Object& obj)
{
	obj["id"] = id;
	obj["ip"] = ip;
	obj["name"] = name;
}

std::string UDeviceSummary::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDeviceSummary::FillMembers(const json::Object& obj)
{
	id = obj["id"];
	ip = obj["ip"];
	name = obj["name"].ToString();
}

UDeviceSummary UDeviceSummary::Deserialize(const json::Object& obj)
{
	UDeviceSummary o;
	o.FillMembers(obj);
	return o;
}

