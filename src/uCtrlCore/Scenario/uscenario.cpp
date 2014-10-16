#include "uscenario.h"

UScenario::UScenario(QObject* parent) : NestedListItem(parent)
{
    m_tasks = new NestedListModel(new UTask(), this);
}

UScenario::~UScenario()
{
}

QVariant UScenario::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case nameRole:
        return name();
    case enabledRole:
        return enabled();
    case lastUpdatedRole:
        return lastUpdated();
    default:
        return QVariant();
    }
}

bool UScenario::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
    case nameRole:
        name(value.toString());
    case enabledRole:
        enabled(value.toBool());
    case lastUpdatedRole:
        lastUpdated(value.toUInt());
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UScenario::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[nameRole] = "name";
    roles[enabledRole] = "isEnabled";
    roles[lastUpdatedRole] = "lastUpdated";

    return roles;
}

ListModel* UScenario::nestedModel() const
{
    return m_tasks;
}
