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
    case firmwareVersionRole:
        return firmwareVersion();
    case nameRole:
        return name();
    case portRole:
        return port();
    case roomRole:
        return room();
    case enabledRole:
        return enabled();
    case ipRole:
        return ip();
    default:
        return QVariant();
    }
}

bool UPlatform::setData(const QVariant& value, int role)
{
    switch (role)
    {
    case idRole:
        id(value.value<QString>());
    case firmwareVersionRole:
        firmwareVersion(value.value<QString>());
    case nameRole:
        name(value.value<QString>());
    case portRole:
        port(value.value<int>());
    case roomRole:
        room(value.value<QString>());
    case enabledRole:
        enabled(value.value<bool>());
    case ipRole:
        ip(value.value<QString>());
    default:
        return false;
    }
    return true;
}

QHash<int, QByteArray> UPlatform::roleNames() const
{
    QHash<int, QByteArray> roles;

    roles[idRole] = "id";
    roles[firmwareVersionRole] = "firmwareVersion";
    roles[nameRole] = "name";
    roles[portRole] = "port";
    roles[roomRole] = "room";
    roles[enabledRole] = "isEnabled";
    roles[ipRole] = "ip";

    return roles;
}

ListModel* UPlatform::nestedModel() const
{
    return m_devices;
}
