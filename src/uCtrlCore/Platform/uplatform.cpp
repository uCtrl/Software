#include "Utility/uniqueidgenerator.h"
#include "uplatform.h"

UPlatform::UPlatform(QObject* parent) : QAbstractListModel(parent)
{
}

UPlatform::UPlatform(QObject* parent, const QString& id) : QAbstractListModel(parent)
{
    setId(id);
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
    foreach(UDevice* device, m_devices) {
        delete device;
    }
    m_devices.clear();
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

void UPlatform::addDevice(UDevice *device)
{
    m_devices.push_back(device);
}

void UPlatform::deleteDevice(const QString &id)
{
    for(int i = 0; i < m_devices.count(); i++)
    {
        if (m_devices[i]->getId() != id) continue;

        m_devices.removeAt(i);
        delete m_devices[i];
    }
}

bool UPlatform::containsDevice(const QString &id)
{
    for(int i = 0; i < m_devices.count(); i++)
    {
        if (m_devices[i]->getId() == id)
            return true;
    }
    return false;
}

UDevice *UPlatform::findDevice(const QString &id)
{
    for(int i = 0; i < m_devices.count(); i++)
    {
        if (m_devices[i]->getId() == id)
            return m_devices[i];
    }
    return 0;
}

void UPlatform::copyProperties(UPlatform* platform)
{
    this->setName(platform->getName());
    this->setRoom(platform->getRoom());
    this->setEnabled(platform->getEnabled());
    this->setIp(platform->getIp());
    this->setPort(platform->getPort());
    this->setFirmwareVersion(platform->getFirmwareVersion());
}

void UPlatform::save()
{
    emit savePlatform();
}

void UPlatform::read(const QJsonObject &jsonObj)
{
    this->setId(jsonObj["id"].toString());
    this->setName(jsonObj["name"].toString());
    this->setRoom(jsonObj["room"].toString());
    this->setEnabled(jsonObj["enabled"].toBool());
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
