#include "Utility/uniqueidgenerator.h"
#include "uplatform.h"

UPlatform::UPlatform(QObject* parent) : QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UPlatform::UPlatform(QObject* parent, const QString& ip, const int port) : QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
    setIp(ip);
    setPort(port);
}

UPlatform::~UPlatform()
{
}

UPlatform::UPlatform(const UPlatform& platform)
{
    setId(platform.getId());
    setIp(platform.getIp());
    setPort(platform.getPort());
    setDevices(platform.getDevices());
}

QVariant UPlatform::data(const QModelIndex & index, int role) const {
    return QVariant();
}

int UPlatform::rowCount(const QModelIndex &parent) const
{
    return 0;
}

void UPlatform::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    this->setIp(jsonObj["ip"].toString());
    this->setPort(jsonObj["port"].toInt());

    QJsonArray devicesArray = jsonObj["devices"].toArray();
    foreach(QJsonValue deviceJson, devicesArray)
    {
        UDevice* d = new UDevice(this);
        d->read(deviceJson.toObject());
        this->m_devices.append(d);
    }
}

void UPlatform::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["ip"] = getIp();
    jsonObj["port"] = getPort();

    QJsonArray devicesArray;
    foreach(UDevice* device, this->m_devices)
    {
        QJsonObject deviceJson;
        device->write(deviceJson);
        devicesArray.append(deviceJson);
    }

    jsonObj["devices"] = devicesArray;
}
