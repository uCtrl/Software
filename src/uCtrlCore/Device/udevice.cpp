#include "udevice.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UDevice::UDevice(QObject* parent) : QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UDevice::~UDevice()
{
}

UDevice::UDevice(const UDevice& device)
{
    setId(device.getId());
    setName(device.getName());
    setScenarios(device.getScenarios());
}

void UDevice::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    this->setName(jsonObj["name"].toString());
    this->setMinValue(jsonObj["minValue"].toDouble());
    this->setMaxValue(jsonObj["maxValue"].toDouble());
    this->setPrecision(jsonObj["precision"].toInt());
    this->setUnitLabel(jsonObj["unitLabel"].toString());
    this->setType(jsonObj["type"].toInt());
    this->setMac(jsonObj["mac"].toString());
    this->setFirmwareVersion(jsonObj["firmwareVersion"].toString());
    this->setIsTriggerValue(jsonObj["isTriggerValue"].toBool());

    QJsonArray scenariosArray = jsonObj["scenarios"].toArray();
    foreach(QJsonValue scenarioJson, scenariosArray)
    {
        UScenario* s = new UScenario(this);
        s->read(scenarioJson.toObject());
        this->m_scenarios.append(s);
    }
}

void UDevice::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["name"] = getName();
    jsonObj["minValue"] = getMinValue();
    jsonObj["maxValue"] = getMaxValue();
    jsonObj["precision"] = getPrecision();
    jsonObj["unitLabel"] = getUnitLabel();
    jsonObj["type"] = getType();
    jsonObj["mac"] = getMac();
    jsonObj["firmwareVersion"] = getFirmwareVersion();
    jsonObj["isTriggerValue"] = isTriggerValue();

    QJsonArray scenariosArray;
    foreach(UScenario* scenario, this->m_scenarios)
    {
        QJsonObject scenarioJson;
        scenario->write(scenarioJson);
        scenariosArray.append(scenarioJson);
    }

    jsonObj["scenarios"] = scenariosArray;
}
