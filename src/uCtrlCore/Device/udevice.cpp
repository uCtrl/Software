#include "udevice.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UDevice::UDevice(QObject* parent) : QAbstractListModel(parent)
{
}

UDevice::UDevice(QObject* parent, const QString& id) : QAbstractListModel(parent)
{
    setId(id);
    setLastUpdate(QDateTime::currentDateTime());
}

UDevice::~UDevice()
{
    foreach(UScenario* scenario, m_scenarios) {
        delete scenario;
    }
    m_scenarios.clear();
}

UDevice::UDevice(const UDevice& device)
{
    setId(device.getId());
    setName(device.getName());
    setScenarios(device.getScenarios());
    setLastUpdate(QDateTime::currentDateTime());
}

QObject* UDevice::createScenario()
{
    UScenario* newScenario = new UScenario(this);
    UTask* otherwiseTask = (UTask*)newScenario->createTask();
    newScenario->addTask(otherwiseTask);
    return newScenario;
}

void UDevice::addScenario(UScenario* scenario)
{
    beginInsertRows(QModelIndex(), rowCount(), rowCount());
    m_scenarios.push_back(scenario);
    endInsertRows();

    emit scenariosChanged(m_scenarios);
}

void UDevice::updateScenarioAt(int index, UScenario* scenario)
{
    m_scenarios.replace(index, scenario);

    emit scenariosChanged(m_scenarios);
}

void UDevice::saveScenarios()
{
    emit save();
}

void UDevice::deleteScenario(const QString &id)
{
    for(int i = 0; i < m_scenarios.count(); i++) {
        if (m_scenarios[i]->getId() != id)  {
            deleteScenarioAt(i);
            return;
        }
    }
}

UScenario *UDevice::findScenario(const QString &id)
{
    for(int i = 0; i < m_scenarios.count(); i++) {
        if (m_scenarios[i]->getId() == id)
            return m_scenarios[i];
    }
    return 0;
}

bool UDevice::containsScenario(const QString &id)
{
    for(int i = 0; i < m_scenarios.count(); i++) {
        if (m_scenarios[i]->getId() == id)
            return true;
    }
    return false;
}

void UDevice::copyProperties(UDevice* device)
{
    this->setName(device->getName());
    this->setMinValue(device->getMinValue());
    this->setMaxValue(device->getMaxValue());
    this->setPrecision(device->getPrecision());
    this->setUnitLabel(device->getUnitLabel());
    this->setType(device->getType());
    this->setIsTriggerValue(device->isTriggerValue());
    this->setEnabled(device->getEnabled());
    this->setDescription(device->getDescription());
    this->setStatus(device->getStatus());
    this->setLastUpdate(QDateTime::currentDateTime());
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
    this->setId(jsonObj["id"].toString());
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
    this->setLastUpdate(QDateTime::currentDateTime());

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
