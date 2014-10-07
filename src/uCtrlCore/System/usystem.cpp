#include "usystem.h"
#include "Device/udevicelist.h"

USystem* USystem::m_systemInstance = NULL;

USystem* USystem::Instance()
{
    if(!m_systemInstance)
        m_systemInstance = new USystem();

    return m_systemInstance;
}

void USystem::addPlatform(UPlatform* platform)
{
    m_platforms.push_back(platform);
}

void USystem::deletePlatform(const QString &id)
{
    for(int i = 0; i < m_platforms.count(); i++) {
        if (m_platforms[i]->getId() != id) continue;

        m_platforms.removeAt(i);
        delete m_platforms[i];
    }
}

bool USystem::containsPlatform(const QString& id)
{
    for(int i = 0; i < m_platforms.count(); i++) {
        if (m_platforms[i]->getId() == id)
            return true;
    }
    return false;
}

UPlatform* USystem::findPlatform(const QString& id)
{
    for(int i = 0; i < m_platforms.count(); i++) {
        if (m_platforms[i]->getId() == id)
            return m_platforms[i];
    }
    return 0;
}

QVariant USystem::data(const QModelIndex &index, int role) const
{
    return QVariant();
}

QObject* USystem::getPlatformAt(int index) const {
    if (index < 0 || index >= m_platforms.count())
        return 0;

    return (QObject*) (getPlatforms().at(index));
}

int USystem::rowCount(const QModelIndex &parent) const
{
    return m_platforms.count();
}

QObject* USystem::getAllDevices()
{
    UDeviceList* deviceList = new UDeviceList();

    QList<UDevice*> actualDeviceList;
    for (int i = 0; i < m_platforms.length(); i++) {
        UPlatform* platform = m_platforms.at(i);

        QList<UDevice*> tmpDeviceList = platform->getDevices();
        for (int j = 0; j < tmpDeviceList.length(); j++) {
            UDevice* tmpDevice = tmpDeviceList.at(j);
            actualDeviceList.push_back(tmpDevice);
        }
    }
    deviceList->setDevices(actualDeviceList);
    return deviceList;
}

void USystem::read(const QJsonObject &jsonObj)
{
    QJsonArray platformsArray = jsonObj["platforms"].toArray();
    foreach(QJsonValue platformJson, platformsArray) {
        UPlatform* p = new UPlatform(this);
        p->read(platformJson.toObject());
        this->m_platforms.append(p);
    }
}

void USystem::write(QJsonObject &jsonObj) const
{
    QJsonArray platformsArray;
    foreach(UPlatform* p, this->m_platforms) {
        QJsonObject platformJson;
        p->write(platformJson);
        platformsArray.append(platformJson);
    }

    jsonObj["platforms"] = platformsArray;
}
