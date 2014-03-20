#include "udeviceinfo.h"

UDeviceInfo::UDeviceInfo()
{
}

UDeviceInfo::UDeviceInfo(const UDeviceInfo& deviceInfo)
{
    setMinValue(deviceInfo.getMinValue());
    setMaxValue(deviceInfo.getMaxValue());
    setPrecision(deviceInfo.getPrecision());
    setType(deviceInfo.getType());
    setUnitLabel(deviceInfo.getUnitLabel());
}

void UDeviceInfo::FillObject(json::Object& obj) const
{
    obj["minValue"] = getMinValue();
    obj["maxValue"] = getMaxValue();
    obj["precision"] = getPrecision();
    obj["unitLabel"] = getUnitLabel();
    obj["type"] = getType();
}

void UDeviceInfo::FillMembers(const json::Object& obj)
{
    setMinValue(obj["minValue"]);
    setMaxValue(obj["maxValue"]);
    setPrecision(obj["precision"]);
    setUnitLabel(obj["unitLabel"].ToString());
    setType(obj["type"]);
}
