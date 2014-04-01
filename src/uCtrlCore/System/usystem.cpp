#include "usystem.h"

USystem* USystem::m_systemInstance = NULL;

USystem* USystem::Instance()
{
    if(!m_systemInstance)
        m_systemInstance = new USystem();

    return m_systemInstance;
}


void USystem::addPlatform(const QString& ip, const int port)
{
    UPlatform* platform = new UPlatform(USystem::Instance(), ip, port);
    m_platforms.append(platform);
    platform->createSocket();
}

bool USystem::containsPlatform(const QString& ip, const int port)
{
    for(int i = 0; i < m_platforms.count(); i++)
    {
        if (m_platforms[i]->getIp() == ip && m_platforms[i]->getPort() == port)
            return true;
    }
    return false;
}

QVariant USystem::data(const QModelIndex &index, int role) const
{
    return QVariant();
}

int USystem::rowCount(const QModelIndex &parent) const
{
    return 0;
}

void USystem::read(const QJsonObject &jsonObj)
{
    QJsonArray platformsArray = jsonObj["platforms"].toArray();
    foreach(QJsonValue platformJson, platformsArray)
    {
        UPlatform* p = new UPlatform(this);
        p->read(platformJson.toObject());
        this->m_platforms.append(p);
    }
}

void USystem::write(QJsonObject &jsonObj) const
{
    QJsonArray platformsArray;
    foreach(UPlatform* p, this->m_platforms)
    {
        QJsonObject platformJson;
        p->write(platformJson);
        platformsArray.append(platformJson);
    }

    jsonObj["platforms"] = platformsArray;
}
