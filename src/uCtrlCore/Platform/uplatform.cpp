#include "uplatform.h"

UPlatform::UPlatform(QObject* parent, bool isLocalPlatform) : NestedListItem(parent)
{
    m_devices = new UDevicesModel(this);
    m_isLocalPlatform = isLocalPlatform;
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
        return (int)status();
    case lastUpdatedRole:
        return lastUpdated();
    case isLocalPlatformRole:
        return isLocalPlatform();
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
        break;
    case nameRole:
        name(value.toString());
        break;
    case firmwareVersionRole:
        firmwareVersion(value.toString());
        break;
    case ipRole:
        ip(value.toString());
        break;
    case portRole:
        port(value.toInt());
        break;
    case roomRole:
        room(value.toString());
        break;
    case statusRole:
        status((UEStatus)value.toInt());
        break;
    case lastUpdatedRole:
        lastUpdated(value.toDouble());
        break;
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
    roles[lastUpdatedRole] = "lastUpdated";
    roles[isLocalPlatformRole] = "isLocalPlatform";

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
    jsonObj["status"] = (int)this->status();
    jsonObj["lastUpdated"] = this->lastUpdated();

    QJsonObject devices;
    m_devices->write(devices);
    jsonObj["devices"] = devices["devices"];
}

void UPlatform::read(const QJsonObject& jsonObj)
{
    this->id(jsonObj["id"].toString());
    this->firmwareVersion(jsonObj["firmwareVersion"].toString());
    this->name(jsonObj["name"].toString());
    this->ip(jsonObj["ip"].toString());
    this->port(jsonObj["port"].toInt());
    this->room(jsonObj["room"].toString());
    this->status((UEStatus)jsonObj["status"].toInt());
    this->lastUpdated(jsonObj["lastUpdated"].toDouble());

    readDevices(jsonObj);
}

void UPlatform::readDevices(const QJsonObject &jsonObj)
{
    m_devices->read(jsonObj);
}

QString UPlatform::name() const
{
    return m_name;
}

void UPlatform::name(const QString &name)
{
    if (m_name != name) {
        m_name = name;
        emit dataChanged();
    }
}

QString UPlatform::firmwareVersion() const
{
    return m_firmwareVersion;
}

void UPlatform::firmwareVersion(const QString &firmwareVersion)
{
    if (m_firmwareVersion != firmwareVersion) {
        m_firmwareVersion = firmwareVersion;
        emit dataChanged();
    }
}

QString UPlatform::ip() const
{
    return m_ip;
}

void UPlatform::ip(const QString &ip)
{
    if (m_ip != ip) {
        m_ip = ip;
        emit dataChanged();
    }
}

int UPlatform::port() const
{
    return m_port;
}

void UPlatform::port(int port)
{
    if (m_port != port) {
        m_port = port;
        emit dataChanged();
    }
}

QString UPlatform::room() const
{
    return m_room;
}

void UPlatform::room(const QString &room)
{
    if (m_room != room) {
        m_room = room;
        emit dataChanged();
    }
}

UPlatform::UEStatus UPlatform::status() const
{
    return m_status;
}

void UPlatform::status(UEStatus status)
{
    if (m_status != status) {
        m_status = status;
        emit dataChanged();
    }
}

bool UPlatform::isLocalPlatform() const
{
    return m_isLocalPlatform;
}
