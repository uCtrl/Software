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
        QString id = platformObj["id"].toString();
        ListItem* p = find(id);

        if (p) {
            p->read(platformObj);
        } else {
            p = new UPlatform(this);
            p->read(platformObj);
            this->appendRow(p);
        }
    }
}

QObject* UPlatformsModel::getRecommendations()
{
    return m_recModel;
}
