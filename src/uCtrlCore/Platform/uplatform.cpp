#include "uplatform.h"

UPlatform::UPlatform(QObject* parent) : NestedListItem(parent)
{
    m_devices = new UDevicesModel(this);
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

void UPlatform::write(QJsonObject& jsonObj) const
{
    jsonObj["id"] = this->id();
    jsonObj["firmwareVersion"] = this->firmwareVersion();
    jsonObj["name"] = this->name();
    jsonObj["ip"] = this->ip();
    jsonObj["port"] = this->port();
    jsonObj["room"] = this->room();
    jsonObj["status"] = this->status();
    jsonObj["enabled"] = this->enabled();
    jsonObj["lastUpdated"] = QString::number(this->lastUpdated());

    QJsonObject devices;
    m_devices->write(devices);
    jsonObj["devices"] = devices;
}

void UPlatform::read(const QJsonObject& jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->firmwareVersion(jsonObj["firmwareVersion"].toString());
    this->name(jsonObj["name"].toString());
    this->ip(jsonObj["ip"].toString());
    this->port(jsonObj["port"].toInt());
    this->room(jsonObj["room"].toString());
    this->status(jsonObj["status"].toInt());
    this->enabled(jsonObj["enabled"].toBool());
    this->lastUpdated(jsonObj["lastUpdated"].toString().toUInt());

    m_devices->read(jsonObj);
}
