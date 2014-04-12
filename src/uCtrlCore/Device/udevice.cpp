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

QObject* UDevice::createScenario() {
    UScenario* newScenario = new UScenario(this);
    UTask* otherwiseTask = (UTask*)newScenario->createTask();
    newScenario->addTask(otherwiseTask);
    return newScenario;
}

void UDevice::addScenario(UScenario* scenario) {
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_scenarios.push_back(scenario);
    endInsertRows();

    emit scenariosChanged(m_scenarios);
}

void UDevice::deleteScenarioAt(int index) {
    if (index < 0 || index >= getScenarioCount())
        return;

    beginRemoveRows(QModelIndex(), index, index);

    QObject* scenario = getScenarioAt(index);
    delete scenario;
    scenario = NULL;
    m_scenarios.removeAt(index);

    endRemoveRows();

    emit scenariosChanged(m_scenarios);
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
    this->setIsTriggerValue(jsonObj["isTriggerValue"].toBool());
    this->setEnabled(jsonObj["enabled"].toString());
    this->setDescription(jsonObj["description"].toString());
    this->setStatus((float)jsonObj["status"].toDouble());

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
    jsonObj["isTriggerValue"] = isTriggerValue();
    jsonObj["enabled"] = getEnabled();
    jsonObj["description"] = getDescription();
    jsonObj["status"] = getStatus();

    QJsonArray scenariosArray;
    foreach(UScenario* scenario, this->m_scenarios)
    {
        QJsonObject scenarioJson;
        scenario->write(scenarioJson);
        scenariosArray.append(scenarioJson);
    }

    jsonObj["scenarios"] = scenariosArray;
}
