#include "udeviceinfo.h"

UDeviceInfo::UDeviceInfo(QObject *parent)
    : QObject(parent)
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

void UDeviceInfo::fillObject(json::Object& obj) const
{
    obj["minValue"] = getMinValue();
    obj["maxValue"] = getMaxValue();
    obj["precision"] = getPrecision();
    obj["unitLabel"] = getUnitLabel().toStdString();
    obj["type"] = getType();
}

void UDeviceInfo::fillMembers(const json::Object& obj)
{
    setMinValue(obj["minValue"]);
    setMaxValue(obj["maxValue"]);
    setPrecision(obj["precision"]);
    setUnitLabel(QString::fromStdString(obj["unitLabel"].ToString()));
    setType(obj["type"]);
}
