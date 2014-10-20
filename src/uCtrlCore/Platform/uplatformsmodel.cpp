#include "uplatformsmodel.h"

UPlatformsModel::UPlatformsModel(QObject* parent) : NestedListModel(new UPlatform, parent)
{
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
        UPlatform* p = new UPlatform(this);
        p->read(platform.toObject());
        this->appendRow(p);
    }
}
