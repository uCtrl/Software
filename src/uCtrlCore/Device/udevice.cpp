#include "udevice.h"
#include "Utility/uniqueidgenerator.h"
#include <sstream>

UDevice::UDevice(QObject* parent)
    : QAbstractListModel(parent)
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

void UDevice::fillObject(json::Object& obj) const
{
    obj["id"] = getId();
    obj["name"] = getName().toStdString();

    // WARNING : Custom code
    obj["scenarios_size"] = (int) getScenarios().size();
    for (int i = 0; i < getScenarios().size(); i++)
    {
        std::ostringstream oss;
        oss << "scenarios[" << i << "]";

        std::string key = oss.str();
        obj[key] = getScenarios()[i]->toObject();
    }

    // Device Info
    obj["minValue"] = getMinValue();
    obj["maxValue"] = getMaxValue();
    obj["precision"] = getPrecision();
    obj["unitLabel"] = getUnitLabel().toStdString();
    obj["type"] = getType();
}

void UDevice::fillMembers(const json::Object& obj)
{
    setId(obj["id"]);
    setName(QString::fromStdString(obj["name"].ToString()));

    // WARNING : Custom code
    int m_scenarios_size = obj["scenarios_size"];
    for (int i = 0 ; i < m_scenarios_size; i++)
    {
        std::ostringstream oss;
        oss << "scenarios[" << i << "]";

        std::string key = oss.str();
        UScenario* scenario = new UScenario();
        scenario->deserialize(obj[key]);
        m_scenarios.push_back(scenario);
    }
    // Device Info
    setMinValue(obj["minValue"]);
    setMaxValue(obj["maxValue"]);
    setPrecision(obj["precision"]);
    setUnitLabel(QString::fromStdString(obj["unitLabel"].ToString()));
    setType(obj["type"]);
}
