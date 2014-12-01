#include "uplatformsmodel.h"

UPlatformsModel::UPlatformsModel(QObject* parent) : NestedListModel(new UPlatform, parent)
{
    m_recModel = new RecommendationsModel(this);
}

UPlatformsModel::~UPlatformsModel()
{
    m_recModel->clear();
    delete m_recModel;
}

void UPlatformsModel::write(QJsonObject& jsonObj) const
{
    QJsonArray platforms;
    foreach(ListItem* platform, this->m_items)
    {
        QJsonObject p;
        platform->write(p);
        platforms.append(p);
    }
    jsonObj["platforms"] = platforms;
}

void UPlatformsModel::read(const QJsonObject& jsonObj)
{
    QJsonArray platforms = jsonObj["platforms"].toArray();
    foreach(QJsonValue platform, platforms)
    {
        QJsonObject platformObj = platform.toObject();
        readPlatform(platformObj);
    }
}

void UPlatformsModel::readPlatform(const QJsonObject &jsonObj)
{
    QString id = jsonObj["id"].toString();
    ListItem* p = find(id);

    if (p) {
        p->read(jsonObj);
    } else {
        p = new UPlatform(this);
        p->read(jsonObj);
        this->appendRow(p);
    }
}

QObject* UPlatformsModel::getRecommendations()
{
    return m_recModel;
}

QList<UDevice*> UPlatformsModel::findDevicesByType(UDevice::UEType deviceType)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UPlatform* platform = (UPlatform*)item;
        UDevicesModel* devicesModel = (UDevicesModel*)platform->nestedModel();

        QList<UDevice*> subDeviceList = devicesModel->findDevicesByType(deviceType);
        foreach(UDevice* device, subDeviceList) {
            deviceList.push_back(device);
        }
    }
    return deviceList;
}

QList<UDevice*> UPlatformsModel::findDevicesByLocation(const QString& locationName)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UPlatform* platform = (UPlatform*)item;
        UDevicesModel* devicesModel = (UDevicesModel*)platform->nestedModel();

        if (locationName.toLower() == platform->room().toLower())
        {
            QList<ListItem*> subDeviceList = devicesModel->getItems();
            foreach(ListItem* device, subDeviceList) {
                deviceList.push_back((UDevice*)device);
            }
        }
        else
        {
            QList<UDevice*> subDeviceList = devicesModel->findDevicesByName(locationName);
            foreach(UDevice* device, subDeviceList) {
                deviceList.push_back(device);
            }
        }
    }
    return deviceList;
}

QList<UDevice*> UPlatformsModel::findDevicesByName(const QString& deviceName)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UPlatform* platform = (UPlatform*)item;
        UDevicesModel* devicesModel = (UDevicesModel*)platform->nestedModel();

        QList<UDevice*> subDeviceList = devicesModel->findDevicesByName(deviceName);
        foreach(UDevice* device, subDeviceList) {
            deviceList.push_back(device);
        }
    }
    return deviceList;
}

QList<UDevice*> UPlatformsModel::findDevicesByTypeAndName(UDevice::UEType deviceType, const QString& deviceName)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UPlatform* platform = (UPlatform*)item;
        UDevicesModel* devicesModel = (UDevicesModel*)platform->nestedModel();

        QList<UDevice*> subDeviceList = devicesModel->findDevicesByTypeAndName(deviceType, deviceName);
        foreach(UDevice* device, subDeviceList) {
            deviceList.push_back(device);
        }
    }
    return deviceList;
}

QList<UDevice*> UPlatformsModel::findDevicesByTypeAndId(UDevice::UEType deviceType, int deviceId)
{
    QList<UDevice*> deviceList;
    foreach(ListItem *item, m_items) {
        UPlatform* platform = (UPlatform*)item;
        UDevicesModel* devicesModel = (UDevicesModel*)platform->nestedModel();

        QList<UDevice*> subDeviceList = devicesModel->findDevicesByTypeAndId(deviceType, deviceId);
        foreach(UDevice* device, subDeviceList) {
            deviceList.push_back(device);
        }
    }
    return deviceList;
}


