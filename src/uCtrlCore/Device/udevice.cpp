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

QObject* UDevice::getComboBoxItemList()
{
    QList<UComboBoxItemData*> comboBoxItemDatas;

    for (float i = m_minValue; i < m_maxValue; i += m_precision)
    {
        UComboBoxItemData* tmpComboBoxItemData = new UComboBoxItemData();
        tmpComboBoxItemData->setValue(QString::number(i, 'f', 1));
        // TODO : Create an optional map where we can set displayed value text for each device
        tmpComboBoxItemData->setDisplayedValue(QString::number(i, 'f', 1));
        tmpComboBoxItemData->setIconId("");

        comboBoxItemDatas.push_back(tmpComboBoxItemData);
    }

    return new UComboBoxItemList(comboBoxItemDatas);
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
    this->setUnitLabel(jsonObj["unitlabel"].toString());
    this->setType(jsonObj["type"].toInt());

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

    QJsonArray scenariosArray;
    foreach(UScenario* scenario, this->m_scenarios)
    {
        QJsonObject scenarioJson;
        scenario->write(scenarioJson);
        scenariosArray.append(scenarioJson);
    }

    jsonObj["scenarios"] = scenariosArray;
}
