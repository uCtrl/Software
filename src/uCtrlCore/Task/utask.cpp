#include "utask.h"

UTask::UTask(QObject* parent) : NestedListItem(parent)
{
    m_conditions = new ListModel(new UCondition(), this);
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
    case valueRole:
        this->value(value.toString());
    case enabledRole:
        enabled(value.toBool());
    case lastUpdatedRole:
        lastUpdated(value.toUInt());
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
