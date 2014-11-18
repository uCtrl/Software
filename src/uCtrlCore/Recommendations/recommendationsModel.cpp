#include "recommendationsModel.h"

RecommendationsModel::RecommendationsModel(QObject* parent) : ListModel(new Recommendation, parent)
{
}

void RecommendationsModel::write(QJsonObject& jsonObj) const
{
    Q_UNUSED(jsonObj)
}

void RecommendationsModel::read(const QJsonObject& jsonObj)
{
    QJsonArray recommendations = jsonObj["recommendations"].toArray();
    foreach(QJsonValue recommendation, recommendations)
    {
        QJsonObject recommendationObj = recommendation.toObject();
        QString id = recommendationObj["id"].toString();
        ListItem* p = find(id);

        if (p) {
            p->read(recommendationObj);
        } else {
            p = new Recommendation(this);
            p->read(recommendationObj);
            this->appendRow(p);
        }
    }
}
