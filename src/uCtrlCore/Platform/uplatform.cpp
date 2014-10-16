#include "uplatform.h"

UPlatform::UPlatform(QObject* parent) : NestedListItem(parent)
{
    m_devices = new NestedListModel(new UDevice(), this);
}

UPlatform::~UPlatform()
{
}

QVariant UPlatform::data(int role) const
{
    switch (role)
    {
    case idRole:
        return id();
    case nameRole:
        return name();
    case firmwareVersionRole:
        return firmwareVersion();
    case ipRole:
        return ip();
    case portRole:
        return port();
    case roomRole:
        return room();
    case statusRole:
        return room();
    case enabledRole:
        return enabled();
    case lastUpdatedRole:
        return lastUpdated();
    default:
        return QVariant();
    }
}

bool UPlatform::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.toString());
    case nameRole:
        name(value.toString());
    case firmwareVersionRole:
        firmwareVersion(value.toString());
    case ipRole:
        ip(value.toString());
    case portRole:
        port(value.toInt());
    case roomRole:
        room(value.toString());
    case statusRole:
        status(value.toInt());
    case enabledRole:
        enabled(value.toBool());
    case lastUpdatedRole:
        lastUpdated(value.toUInt());
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UPlatform::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[nameRole] = "name";
    roles[firmwareVersionRole] = "firmwareVersion";
    roles[ipRole] = "ip";
    roles[portRole] = "port";
    roles[roomRole] = "room";
    roles[statusRole] = "status";
    roles[enabledRole] = "isEnabled";
    roles[lastUpdatedRole] = "lastUpdated";

    return roles;
}

ListModel* UPlatform::nestedModel() const
{
    return m_devices;
}
