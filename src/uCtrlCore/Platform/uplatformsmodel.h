#ifndef UPLATFORMSMODEL_H
#define UPLATFORMSMODEL_H

#include "Models/nestedlistmodel.h"
#include "Recommendations/recommendationsModel.h"
#include "uplatform.h"
#include "Device/udevice.h"

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

    // Helper functions
    QList<UDevice*> findDevicesByType(UDevice::UEType deviceType);
    QList<UDevice*> findDevicesByLocation(const QString& locationName);
    QList<UDevice*> findDevicesByName(const QString& deviceName);

private:
    RecommendationsModel* m_recModel;
};

#endif // UPLATFORMSMODEL_H
