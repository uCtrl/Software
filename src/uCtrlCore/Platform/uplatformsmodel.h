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
    void readPlatform(const QJsonObject &jsonObj);

    // Recommendations
    Q_INVOKABLE QObject* getRecommendations();

    // Helper functions
    QList<UDevice*> findDevicesByType(UDevice::UEType deviceType);
    QList<UDevice*> findDevicesByLocation(const QString& locationName);
    QList<UDevice*> findDevicesByName(const QString& deviceName);
    QList<UDevice*> findDevicesByTypeAndName(UDevice::UEType deviceType, const QString& deviceName);

    // Statistics
    /*Q_INVOKABLE QString minStat() const;
    Q_INVOKABLE void minStat(const QString& minStat);
    Q_INVOKABLE QString maxStat() const;
    Q_INVOKABLE void maxStat(const QString& maxStat);
    Q_INVOKABLE QString meanStat() const;
    Q_INVOKABLE void meanStat(const QString& meanStat);
    Q_INVOKABLE QString countStat() const;
    Q_INVOKABLE void countStat(const QString& countStat);*/

private:
    RecommendationsModel* m_recModel;

    QString m_maxStat;
    QString m_minStat;
    QString m_meanStat;
    QString m_countStat;
    ListModel* m_statistics;
};

#endif // UPLATFORMSMODEL_H
