#include "ustatisticsmodel.h"

UStatisticsModel::UStatisticsModel(QObject *parent) : ListModel(new UStatistic, parent)
{
}

void UStatisticsModel::write(QJsonObject& jsonObj) const
{
    Q_UNUSED(jsonObj)
}

void UStatisticsModel::read(const QJsonObject& jsonObj)
{
    QJsonArray statistics = jsonObj["statistics"].toArray();
    foreach(QJsonValue statistic, statistics)
    {
        ListItem* s = new UStatistic(this);
        s->read(statistic.toObject());
        this->appendRow(s);
    }
}
