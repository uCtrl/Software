#ifndef UPLATFORMSMODEL_H
#define UPLATFORMSMODEL_H

#include "Models/nestedlistmodel.h"
#include "Recommendations/recommendationsModel.h"
#include "uplatform.h"

class UPlatformsModel : public NestedListModel
{
    Q_OBJECT

public:
    explicit UPlatformsModel(QObject* parent = 0);
    ~UPlatformsModel();

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    // Recommendations
    Q_INVOKABLE QObject* getRecommendations();

private:
    RecommendationsModel* m_recModel;
};

#endif // UPLATFORMSMODEL_H
