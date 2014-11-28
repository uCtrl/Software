#ifndef USTATISTICSMODEL_H
#define USTATISTICSMODEL_H

#include "Models/listmodel.h"
#include "ustatistic.h"

class UStatisticsModel : public ListModel
{
    Q_OBJECT

public:
    explicit UStatisticsModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

signals:
    void statsReceived();
};

#endif // USTATISTICSMODEL_H
