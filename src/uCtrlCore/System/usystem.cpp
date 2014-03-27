#include "usystem.h"
#include "sstream"

USystem::USystem(QObject *parent) : QAbstractListModel(parent)
{
}

USystem::~USystem()
{
}

QVariant USystem::data(const QModelIndex &index, int role) const
{
    return QVariant();
}

int USystem::rowCount(const QModelIndex &parent) const
{
    return 0;
}

void USystem::fillObject(json::Object &obj) const
{
    obj["platforms_size"] = getPlatforms().size();
    for (int i = 0; i < getPlatforms().size(); i++)
    {
        std::ostringstream oss;
        oss << "platforms [" << i << "]";

        std::string key = oss.str();
        obj[key] = getPlatforms().at(i)->toObject();
    }
}

void USystem::fillMembers(const json::Object &obj)
{
    m_platforms.clear();
    int m_platforms_size = obj["platforms_size"];
    for (int i = 0; i < m_platforms_size; i++)
    {
        std::ostringstream oss;
        oss << "platforms[" << i << "]";

        std::string key = oss.str();
        UPlatform* platform = new UPlatform();
        platform->deserialize(obj[key]);
        m_platforms.push_back(platform);
    }
}
