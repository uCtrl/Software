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
        return (UDevice*) item->history();
    return NULL;
}
