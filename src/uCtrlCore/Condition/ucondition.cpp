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
    case typeRole:
        return type();
    case comparisonTypeRole:
        return comparisonType();
    case beginValueRole:
        return beginValue();
    case endValueRole:
        return endValue();
    case deviceIdRole:
        return deviceId();
    case deviceValueRole:
        return deviceValue();
    case enabledRole:
        return enabled();
    case lastUpdatedRole:
        return lastUpdated();
    default:
        return QVariant();
    }
}

bool UCondition::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
    case typeRole:
        type(value.toInt());
    case comparisonTypeRole:
        comparisonType(value.toInt());
    case beginValueRole:
        beginValue(value.toString());
    case endValueRole:
        endValue(value.toString());
    case deviceIdRole:
        deviceId(value.toString());
    case deviceValueRole:
        deviceValue(value.toString());
    case enabledRole:
        enabled(value.toBool());
    case lastUpdatedRole:
        lastUpdated(value.toUInt());
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UCondition::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[typeRole] = "type";
    roles[comparisonTypeRole] = "comparisonType";
    roles[beginValueRole] = "beginValue";
    roles[endValueRole] = "endValue";
    roles[deviceIdRole] = "deviceId";
    roles[deviceValueRole] = "deviceValue";
    roles[enabledRole] = "isEnabled";
    roles[lastUpdatedRole] = "lastUpdated";

    return roles;
}
