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
    case suspendedRole:
        return suspended();
    case nameRole:
        return name();
    case statusRole:
        return status();
    default:
        return QVariant();
    }
}

bool UTask::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.value<QString>());
    case suspendedRole:
        suspended(value.value<bool>());
    case nameRole:
        name(value.value<QString>());
    case statusRole:
        status(value.value<bool>());
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UTask::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[suspendedRole] = "suspended";
    roles[nameRole] = "name";
    roles[statusRole] = "status";

    return roles;
}

ListModel* UTask::nestedModel() const
{
    return m_conditions;
}
