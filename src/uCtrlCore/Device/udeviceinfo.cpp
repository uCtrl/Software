#include "udeviceinfo.h"

UDeviceInfo::UDeviceInfo(const UDeviceInfo& deviceInfo)
{
    this->minValue = deviceInfo.minValue;
    this->maxValue = deviceInfo.maxValue;
    this->precision = deviceInfo.precision;
    this->type = deviceInfo.type;
    this->unitLabel = deviceInfo.unitLabel;
}

json::Object UDeviceInfo::ToObject()
{
	json::Object obj;
	FillObject(obj);
	return obj;
}

void UDeviceInfo::FillObject(json::Object& obj)
{
	obj["minValue"] = minValue;
	obj["maxValue"] = maxValue;
	obj["precision"] = precision;
	obj["unitLabel"] = unitLabel;
	obj["type"] = type;
	obj["deviceSummary"] = deviceSummary.ToObject();
}

std::string UDeviceInfo::Serialize()
{
	json::Object obj = ToObject();
	return json::Serialize(obj);
}

void UDeviceInfo::FillMembers(const json::Object& obj)
{
	minValue = obj["minValue"];
	maxValue = obj["maxValue"];
	precision = obj["precision"];
	unitLabel = obj["unitLabel"].ToString();
	type = obj["type"];
	deviceSummary = UDeviceSummary::Deserialize(obj["deviceSummary"].ToObject());
}

UDeviceInfo UDeviceInfo::Deserialize(const json::Object& obj)
{
	UDeviceInfo o;
	o.FillMembers(obj);
	return o;
}

