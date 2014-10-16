#include "udevice.h"

UDevice::UDevice(QObject* parent) : NestedListItem(parent)
{
    m_scenarios = new NestedListModel(new UScenario(), this);
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
    case nameRole:
        name(value.toString());
    case typeRole:
        type(value.toInt());
    case descriptionRole:
        description(value.toString());
    case maxValueRole:
        maxValue(value.toInt());
    case minValueRole:
        minValue(value.toInt());
    case precisionRole:
        precision(value.toInt());
    case statusRole:
        status(value.toInt());
    case unitLabelRole:
        unitLabel(value.toString());
    case enabledRole:
        enabled(value.toBool());
    case lastUpdatedRole:
        lastUpdated(value.toUInt());
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
