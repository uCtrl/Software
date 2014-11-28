#include "udevicesmodel.h"

UDevicesModel::UDevicesModel(QObject* parent) : NestedListModel(new UDevice, parent)
{
}

void UDevicesModel::write(QJsonObject &jsonObj) const
{
    QJsonArray devices;
    foreach(ListItem* device, this->m_items)
    {
        QJsonObject d;
        device->write(d);
        devices.append(d);
    }
    jsonObj["devices"] = devices;
}

void UDevicesModel::read(const QJsonObject &jsonObj)
{
    QJsonArray devices = jsonObj["devices"].toArray();
    foreach(QJsonValue device, devices)
    {
        QJsonObject deviceObj = device.toObject();
        QString id = deviceObj["id"].toString();
        ListItem* d = find(id);

        if (d) {
            d->read(device.toObject());
        } else {
            d = new UDevice(this);
            d->read(device.toObject());
            this->appendRow(d);
        }
    }
}

QObject* UDevicesModel::getHistoryWithId(const QString &id)
{
    UDevice* item = (UDevice*)find(id);
    if (item != NULL)
        return (UHistoryLogModel*)item->history();
    return NULL;
}

QObject *UDevicesModel::getStatisticsWithId(const QString &id)
{
    UDevice* item = (UDevice*)find(id);
    if (item != NULL)
        return (UStatisticsModel*) item->statistics();
    return NULL;
}

QList<UDevice*> UDevicesModel::findDevicesByType(UDevice::UEType deviceType)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UDevice* device = (UDevice*)item;

        if (device->type() == deviceType)
            deviceList.push_back(device);
    }

    return deviceList;
}

QList<UDevice*> UDevicesModel::findDevicesByName(const QString& deviceName)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UDevice* device = (UDevice*)item;
        if (device->name().toLower() == deviceName.toLower())
            deviceList.push_back(device);
    }
    return deviceList;
}

QList<UDevice*> UDevicesModel::findDevicesByTypeAndName(UDevice::UEType deviceType, const QString& deviceName)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UDevice* device = (UDevice*)item;
        if (device->type() == deviceType && device->name().toLower().contains(deviceName.toLower()))
            deviceList.push_back(device);
    }
    return deviceList;
}
