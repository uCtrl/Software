#include "udevice.h"

UDevice::UDevice(QObject* parent) : NestedListItem(parent)
{
    m_scenarios = new UScenariosModel(this);
}

UDevice::~UDevice()
{
}

QVariant UDevice::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case nameRole:
        return name();
    case typeRole:
        return type();
    case descriptionRole:
        return description();
    case maxValueRole:
        return maxValue();
    case minValueRole:
        return minValue();
    case precisionRole:
        return precision();
    case statusRole:
        return status();
    case unitLabelRole:
        return unitLabel();
    case enabledRole:
        return enabled();
    case lastUpdatedRole:
        return lastUpdated();
    default:
        return QVariant();
    }
}

bool UDevice::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
        break;
    case nameRole:
        name(value.toString());
        break;
    case typeRole:
        type(value.toInt());
        break;
    case descriptionRole:
        description(value.toString());
        break;
    case maxValueRole:
        maxValue(value.toInt());
        break;
    case minValueRole:
        minValue(value.toInt());
        break;
    case precisionRole:
        precision(value.toInt());
        break;
    case statusRole:
        status(value.toInt());
        break;
    case unitLabelRole:
        unitLabel(value.toString());
        break;
    case enabledRole:
        enabled(value.toBool());
        break;
    case lastUpdatedRole:
        lastUpdated(value.toUInt());
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UDevice::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[nameRole] = "name";
    roles[typeRole] = "type";
    roles[descriptionRole] = "description";
    roles[maxValueRole] = "maxValue";
    roles[minValueRole] = "minValue";
    roles[precisionRole] = "precision";
    roles[statusRole] = "status";
    roles[unitLabelRole] = "unitLabel";
    roles[enabledRole] = "isEnabled";
    roles[lastUpdatedRole] = "lastUpdated";

    return roles;
}

ListModel* UDevice::nestedModel() const
{
    return m_scenarios;
}

void UDevice::write(QJsonObject& jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["name"] = this->name();
    jsonObj["type"] = this->type();
    jsonObj["description"] = this->description();
    jsonObj["maxValue"] = this->maxValue();
    jsonObj["minValue"] = this->minValue();
    jsonObj["precision"] = this->precision();
    jsonObj["status"] = this->status();
    jsonObj["unitLabel"] = this->unitLabel();
    jsonObj["enabled"] = this->enabled();
    jsonObj["lastUpdated"] = QString::number(this->lastUpdated());

    QJsonObject scenarios;
    m_scenarios->write(scenarios);
    jsonObj["scenarios"] = scenarios;
}

void UDevice::read(const QJsonObject &jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->name(jsonObj["name"].toString());
    this->type(jsonObj["type"].toInt());
    this->description(jsonObj["description"].toString());
    this->maxValue(jsonObj["maxValue"].toInt());
    this->minValue(jsonObj["minValue"].toInt());
    this->precision(jsonObj["precision"].toInt());
    this->status(jsonObj["status"].toInt());
    this->unitLabel(jsonObj["unitLabel"].toString());
    this->enabled(jsonObj["enabled"].toBool());
    this->lastUpdated(jsonObj["lastUpdated"].toString().toUInt());

    m_scenarios->read(jsonObj);
}
