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
        QJsonObject statisticObj = statistic.toObject();
        QString id = statisticObj["id"].toString();
        QString data = statisticObj["data"].toString();
        int type = statisticObj["data"].toInt();
        uint timestamp = statisticObj["timestamp"].toString().toUInt();

        if (contains(id, data, type, timestamp))
            continue;

        ListItem* s = new UStatistic(this);
        s->read(statisticObj);
        this->appendRow(s);
    }
}

bool UStatisticsModel::contains(const QString &id, const QString &data, int type, uint timestamp)
{
    foreach(ListItem* const s, m_items) {
        UStatistic* statistic = (UStatistic*) s;
        if(statistic->id() == id && statistic->data() == data && statistic->type() == type && statistic->timestamp() == timestamp)
            return true;
    }
    return false;
}
