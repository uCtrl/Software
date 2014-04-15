#include "uconditiondevice.h"

UConditionDevice::UConditionDevice(QObject *parent, UConditionDevice* conditionDevice)
    : UCondition(parent, conditionDevice)
{
    setDeviceType(conditionDevice->getDeviceType());
    setDeviceId(conditionDevice->getDeviceId());
    setBeginValue(conditionDevice->getBeginValue());
    setEndValue(conditionDevice->getEndValue());
}

void UConditionDevice::read(const QJsonObject &jsonObj) {
    UCondition::read(jsonObj);

    setDeviceType((UEDeviceType)jsonObj["deviceType"].toInt());
    setDeviceId(jsonObj["deviceId"].toInt());
    setBeginValue(jsonObj["beginValue"].toDouble());
    setBeginValue(jsonObj["endValue"].toDouble());
}

void UConditionDevice::write(QJsonObject &jsonObj) const {
    UCondition::write(jsonObj);

    jsonObj["deviceType"] = (int)getDeviceType();
    jsonObj["deviceId"] = getDeviceId();
    jsonObj["beginValue"] = getBeginValue();
    jsonObj["endValue"] = getEndValue();
}
