#ifndef UDEVICESMODEL_H
#define UDEVICESMODEL_H

#include "Models/nestedlistmodel.h"
#include "udevice.h"

class UDevicesModel : public NestedListModel
{
    Q_OBJECT

public:
    explicit UDevicesModel(QObject* parent = 0);

    // JsonSerializable
    void write(QJsonObject &jsonObj) const;
    void read(const QJsonObject &jsonObj);

    Q_INVOKABLE QObject* getHistoryWithId(const QString& id);
    Q_INVOKABLE QObject* getStatisticsWithId(const QString& id);

    QList<UDevice*> findDevicesByType(UDevice::UEType deviceType);
    QList<UDevice*> findDevicesByName(const QString& deviceName);
    QList<UDevice*> findDevicesByTypeAndName(UDevice::UEType deviceType, const QString& deviceName);
    QList<UDevice*> findDevicesByTypeAndId(UDevice::UEType deviceType, int deviceId);
};

#endif // UDEVICESMODEL_H
