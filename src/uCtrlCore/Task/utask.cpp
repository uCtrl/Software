#include "utask.h"

UTask::UTask(QObject* parent) : NestedListItem(parent)
{
    m_conditions = new UConditionsModel(this);
}

UTask::~UTask()
{
}

QVariant UTask::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case valueRole:
        return value();
    case enabledRole:
        return enabled();
    case lastUpdatedRole:
        return lastUpdated();
    default:
        return QVariant();
    }
}

bool UTask::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
        break;
    case valueRole:
        this->value(value.toString());
        break;
    case enabledRole:
        enabled(value.toBool());
        break;
    case lastUpdatedRole:
        lastUpdated(value.toDouble());
        break;
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UTask::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[valueRole] = "value";
    roles[enabledRole] = "enabled";
    roles[lastUpdatedRole] = "lastUpdated";

    return roles;
}

ListModel* UTask::nestedModel() const
{
    return m_conditions;
}

void UTask::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["value"] = this->value();
    jsonObj["enabled"] = this->enabled();
    jsonObj["lastUpdated"] = this->lastUpdated();

    QJsonObject conditions;
    m_conditions->write(conditions);
    jsonObj["conditions"] = conditions;
}

void UTask::read(const QJsonObject &jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->value(jsonObj["value"].toString());
    this->enabled(jsonObj["enabled"].toBool());
    this->lastUpdated(jsonObj["lastUpdated"].toDouble());

    readConditions(jsonObj);
}

void UTask::readConditions(const QJsonObject &jsonObj)
{
    m_conditions->read(jsonObj);
}

QString UTask::value() const
{
    return m_value;
}

void UTask::value(const QString &value)
{
    if (m_value != value) {
        m_value = value;
        emit dataChanged();
    }
}
