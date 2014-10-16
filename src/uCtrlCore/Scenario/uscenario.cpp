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
    case activeRole:
        return active();
    default:
        return QVariant();
    }
}

bool UScenario::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.value<QString>());
    case nameRole:
        name(value.value<QString>());
    case activeRole:
        active(value.value<bool>());
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
    roles[activeRole] = "active";

    return roles;
}

ListModel* UScenario::nestedModel() const
{
    return m_tasks;
}
