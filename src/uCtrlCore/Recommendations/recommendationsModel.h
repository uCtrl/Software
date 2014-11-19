#ifndef RECOMMENDATIONMODEL_H
#define RECOMMENDATIONMODEL_H

#include "Models/listmodel.h"
#include "recommendation.h"

class RecommendationsModel : public ListModel
{
    Q_OBJECT

public:
    explicit RecommendationsModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);
};

#endif // RECOMMENDATIONMODEL_H
