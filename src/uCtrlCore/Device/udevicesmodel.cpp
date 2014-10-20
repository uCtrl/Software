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
        UDevice* d = new UDevice(this);
        d->read(device.toObject());
        this->appendRow(d);
    }
}
