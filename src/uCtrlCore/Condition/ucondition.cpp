#include "ucondition.h"

UCondition::UCondition(QObject* parent) : ListItem(parent)
{
}

UCondition::~UCondition()
{
}

QVariant UCondition::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    default:
        return QVariant();
    }
}

bool UCondition::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.value<QString>());
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UCondition::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";

    return roles;
}
