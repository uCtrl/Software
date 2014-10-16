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
    case typeRole:
        return type();
    case descriptionRole:
        return description();
    case enabledRole:
        return enabled();
    case isTriggerValueRole:
        return isTriggerValue();
    case maxValueRole:
        return maxValue();
    case minValueRole:
        return minValue();
    case nameRole:
        return name();
    case precisionRole:
        return precision();
    case statusRole:
        return status();
    case unitLabelRole:
        return unitLabel();
    default:
        return QVariant();
    }
}

bool UDevice::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.value<QString>());
    case typeRole:
        type(value.value<int>());
    case descriptionRole:
        description(value.value<QString>());
    case enabledRole:
        enabled(value.value<bool>());
    case isTriggerValueRole:
        isTriggerValue(value.value<bool>());
    case maxValueRole:
        maxValue(value.value<int>());
    case minValueRole:
        minValue(value.value<int>());
    case nameRole:
        name(value.value<QString>());
    case precisionRole:
        precision(value.value<int>());
    case statusRole:
        status(value.value<int>());
    case unitLabelRole:
        unitLabel(value.value<QString>());
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UDevice::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[typeRole] = "type";
    roles[descriptionRole] = "description";
    roles[enabledRole] = "isEnabled";
    roles[isTriggerValueRole] = "isTriggerValue";
    roles[maxValueRole] = "maxValue";
    roles[minValueRole] = "minValue";
    roles[nameRole] = "name";
    roles[precisionRole] = "precision";
    roles[statusRole] = "status";
    roles[unitLabelRole] = "unitLabel";

    return roles;
}

ListModel* UDevice::nestedModel() const
{
    return m_scenarios;
}
