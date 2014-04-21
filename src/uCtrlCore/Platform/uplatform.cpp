#include "Utility/uniqueidgenerator.h"
#include "uplatform.h"

UPlatform::UPlatform(QObject* parent) : QAbstractListModel(parent)
{
    setId(UniqueIdGenerator::GenerateUniqueId());
}

UPlatform::UPlatform(QObject* parent, const QString& ip, const int port) : QAbstractListModel(parent)
{
    setIp(ip);
    setPort(port);
}

UPlatform::UPlatform(const UPlatform& platform)
{
    setId(platform.getId());
    setIp(platform.getIp());
    setPort(platform.getPort());
    setDevices(platform.getDevices());
}

UPlatform::~UPlatform()
{
}

QObject* UPlatform::getDeviceAt(int index) const {
    if (index < 0 || index >= m_devices.count())
        return 0;

    return (QObject*) ( getDevices().at(index) );
}

QDateTime UPlatform::getLastUpdate() const
{
    QDateTime time;
    for (int i=0;i<m_devices.count(); i++) {
        UDevice device = getDeviceAt(i);
        if (device.getLastUpdate() > time) {
            time = device.getLastUpdate();
        }
    }

    return time;
}


void UPlatform::save()
{
    emit savePlatform();
}

QVariant UPlatform::data(const QModelIndex & index, int role) const {
    return QVariant();
}

int UPlatform::rowCount(const QModelIndex &parent) const
{
    return m_devices.count();
}

void UPlatform::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toInt());
    this->setName(jsonObj["name"].toString());
    this->setRoom(jsonObj["room"].toString());
    this->setEnabled(jsonObj["enabled"].toString());
    this->setIp(jsonObj["ip"].toString());
    this->setPort(jsonObj["port"].toInt());
    this->setFirmwareVersion(jsonObj["firmwareVersion"].toString());

    QJsonArray devicesArray = jsonObj["devices"].toArray();
    foreach(QJsonValue deviceJson, devicesArray)
    {
        UDevice* d = new UDevice(this);
        d->read(deviceJson.toObject());
        this->m_devices.append(d);
        connect(d, SIGNAL(save()), this, SLOT(save()));
    }
}

void UPlatform::write(QJsonObject &jsonObj) const
{
    jsonObj["id"] = getId();
    jsonObj["enabled"] = getEnabled();
    jsonObj["name"] = getName();
    jsonObj["room"] = getRoom();
    jsonObj["firmwareVersion"] = getFirmwareVersion();
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
