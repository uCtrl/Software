#include "uconditiondevice.h"

UConditionDevice::UConditionDevice(QObject *parent, UConditionDevice* conditionDevice)
    : UCondition(parent, UEConditionType::Device)
{
    setDeviceType(conditionDevice->getDeviceType());
}

void UConditionDevice::read(const QJsonObject &jsonObj) {
    UCondition::read(jsonObj);

    setDeviceType((UEDeviceType)jsonObj["deviceType"].toInt());
}

void UConditionDevice::write(QJsonObject &jsonObj) const {
    UCondition::write(jsonObj);

    jsonObj["deviceType"] = (int)getDeviceType();
}
